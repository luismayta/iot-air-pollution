resource "aws_kinesis_stream" "air-pollution" {
  name             = var.project
  shard_count      = 1
  retention_period = 24
}

resource "aws_kinesis_firehose_delivery_stream" "air-pollution" {
  name        = "${var.project}-s3"
  destination = "s3"

  s3_configuration {
    role_arn        = aws_iam_role.air-pollution.arn
    bucket_arn      = aws_s3_bucket.air-pollution.arn
    buffer_size     = 5
    buffer_interval = 60
  }
}
