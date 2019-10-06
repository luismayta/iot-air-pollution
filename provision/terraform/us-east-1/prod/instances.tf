resource "aws_instance" "db" {
  ami = data.aws_ami.ubuntu.id
  lifecycle {
    ignore_changes = ["ami"]
  }
  instance_type        = var.aws_instance_type
  iam_instance_profile = aws_iam_instance_profile.air-pollution.name
  key_name             = aws_key_pair.auth.key_name
  security_groups = [
    aws_security_group.main.name,
    aws_security_group.postgresql.name,
  ]

  provisioner "local-exec" {
    command = "echo ${self.public_ip} ${self.private_ip} > file.log"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = lookup(var.user, "ssh_user")
      private_key = file(lookup(var.aws_keys, "pem"))
      host        = aws_instance.db.public_ip
    }
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get install -y python vim git-core python-pip",
      "touch ~/provisioned", # Troll
    ]
  }

  tags = {
    terraform_id = "${var.stage}-terraform"
    Name         = "${var.namespace}-${var.stage}"
    Stage        = var.stage
    Namespace    = var.namespace
  }

}

resource "aws_eip" "eip" {
  instance = aws_instance.db.id
  vpc      = true
}
