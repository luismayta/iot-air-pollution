locals {
  tags = {
    terraform_id = var.namespace
    Environment  = var.stage
  }
  name        = "${var.namespace}-${var.stage}"
  private_key = "${var.keybase_path}/${var.private_key}"
  public_key  = "${var.keybase_path}/${var.public_key}"
  file_crt    = "${var.keybase_path}/${var.file_crt}"
  root_ca     = "${var.keybase_path}/${var.root_ca}"
  aws_keys = {
    pem = "${var.keybase_path}/${lookup(var.aws_keys, "pem")}"
    pub = "${var.keybase_path}/${lookup(var.aws_keys, "pub")}"
  }
}
