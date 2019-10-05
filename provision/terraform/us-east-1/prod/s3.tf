resource "aws_s3_bucket" "air-pollution" {
  bucket = "${var.project}-${var.stage}"
  acl    = "private"
  versioning {
    enabled = true
  }
}
