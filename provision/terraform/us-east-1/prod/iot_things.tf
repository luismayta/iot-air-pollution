resource "aws_iot_thing" "air-pollution" {
  name            = "air-pollution"
  thing_type_name = "pollution"
}

resource "aws_iot_certificate" "air-pollution" {
  active = true
}

resource "local_file" "certificate_pem" {
  content  = aws_iot_certificate.air-pollution.certificate_pem
  filename = local.file_crt
}

resource "local_file" "public_key" {
  content  = aws_iot_certificate.air-pollution.public_key
  filename = local.public_key
}

resource "local_file" "private_key" {
  content  = aws_iot_certificate.air-pollution.private_key
  filename = local.private_key
}

resource "aws_iot_thing_principal_attachment" "air-pollution" {
  principal = aws_iot_certificate.air-pollution.arn
  thing     = aws_iot_thing.air-pollution.name
}

resource "aws_iot_policy_attachment" "air-pollution-iot" {
  policy = aws_iot_policy.iot.name
  target = aws_iot_certificate.air-pollution.arn
}

resource "aws_iot_policy_attachment" "air-pollution-kinesis" {
  policy = aws_iot_policy.kinesis.name
  target = aws_iot_certificate.air-pollution.arn
}

resource "aws_iot_policy_attachment" "air-pollution-firehose" {
  policy = aws_iot_policy.firehose.name
  target = aws_iot_certificate.air-pollution.arn
}
