resource "aws_s3_bucket" "air-pollution" {
  bucket = "${var.project}-${var.stage}"
  acl    = "private"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "lambda" {
  bucket = "lambda-zappa-${var.project}-${var.stage}"
  acl    = "private"
  versioning {
    enabled = true
  }
}
