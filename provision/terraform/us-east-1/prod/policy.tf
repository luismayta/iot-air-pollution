data "aws_iam_policy_document" "air-pollution" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "iot.amazonaws.com",
        "firehose.amazonaws.com",
        "ec2.amazonaws.com",
        "lambda.amazonaws.com",
        "events.amazonaws.com",
      ]
    }
  }
}

resource "aws_iot_policy" "iot" {
  name   = var.project
  policy = <<EOF
{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": ["iot:*"],
                "Effect": "Allow",
                "Resource": "*"
            }
        ]
}
EOF
}

resource "aws_iot_policy" "kinesis" {
  name   = "${var.project}_kinesis"
  policy = data.aws_iam_policy_document.kinesis.json
}

resource "aws_iot_policy" "firehose" {
  name   = "${var.project}_firehose"
  policy = data.aws_iam_policy_document.firehose.json
}

resource "aws_iam_policy" "sqs" {
  name        = "${var.project}_sqs"
  description = "Policy by aws sqs"
  policy      = data.aws_iam_policy_document.sqs.json
}

data "aws_iam_policy_document" "sqs" {
  statement {
    actions = [
      "sqs:SendMessage"
    ]

    effect = "Allow"

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "kinesis" {
  name        = "${var.project}_kinesis"
  description = "Policy by aws kinesis"
  policy      = data.aws_iam_policy_document.kinesis.json
}

data "aws_iam_policy_document" "kinesis" {
  statement {
    actions = [
      "kinesis:DescribeStream",
      "kinesis:GetShardIterator",
      "kinesis:GetRecords"
    ]

    effect = "Allow"

    resources = [
      aws_kinesis_stream.air-pollution.arn
    ]
  }
}

resource "aws_iam_policy" "firehose" {
  name        = "${var.project}_firehose"
  description = "Policy by aws firehose"
  policy      = data.aws_iam_policy_document.firehose.json
}

data "aws_iam_policy_document" "firehose" {
  statement {
    actions = [
      "firehose:PutRecord",
      "firehose:DescribeDeliveryStream",
      "firehose:ListDeliveryStreams",
    ]

    effect = "Allow"

    resources = [
      aws_kinesis_firehose_delivery_stream.air-pollution.arn,
    ]
  }
}

resource "aws_iam_policy" "s3" {
  name        = "${var.project}_s3"
  description = "Policy by aws s3"
  policy      = data.aws_iam_policy_document.s3.json
}

data "aws_iam_policy_document" "s3" {
  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]

    effect = "Allow"

    resources = [
      aws_s3_bucket.air-pollution.arn,
      "${aws_s3_bucket.air-pollution.arn}/*"
    ]
  }
}
