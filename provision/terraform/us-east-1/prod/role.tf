resource "aws_iam_role" "air-pollution" {
  name               = var.project
  assume_role_policy = data.aws_iam_policy_document.air-pollution.json
}

resource "aws_iam_policy_attachment" "sqs" {
  name = "${var.namespace}-${var.project}-sqs"
  roles = [
    aws_iam_role.air-pollution.name
  ]
  policy_arn = aws_iam_policy.sqs.arn
}

resource "aws_iam_policy_attachment" "kinesis" {
  name = "${var.namespace}-${var.project}-kinesis"
  roles = [
    aws_iam_role.air-pollution.name
  ]
  policy_arn = aws_iam_policy.kinesis.arn
}

resource "aws_iam_instance_profile" "air-pollution" {
  name = "${var.namespace}-${var.stage}-air-pollution-${var.aws_region}"
  role = aws_iam_role.air-pollution.name
}


resource "aws_iam_policy_attachment" "firehose" {
  name = "${var.namespace}-${var.project}-firehose"
  roles = [
    aws_iam_role.air-pollution.name
  ]
  policy_arn = aws_iam_policy.firehose.arn
}

resource "aws_iam_policy_attachment" "s3" {
  name = "${var.namespace}-${var.project}-s3"
  roles = [
    aws_iam_role.air-pollution.name
  ]
  policy_arn = aws_iam_policy.s3.arn
}
