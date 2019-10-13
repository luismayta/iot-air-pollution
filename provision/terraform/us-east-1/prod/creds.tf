#
# AWS Key pair
#
resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(lookup(local.aws_keys, "pub"))

  lifecycle {
    create_before_destroy = true
  }
}
