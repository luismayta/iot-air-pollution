#
# Security group resources
#

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "main" {
  name        = "${var.namespace}-${var.stage}-main-${var.aws_region}"
  description = "permission internet, ssh"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "postgresql" {
  name        = "${var.namespace}-${var.stage}-postgresql"
  description = "permissions port 5432"

  # Http Access from anywhere
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "sgDatabaseServer"
    Project = var.namespace
    Stage   = var.stage
  }
}
