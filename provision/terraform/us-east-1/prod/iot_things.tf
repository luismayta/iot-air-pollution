resource "aws_iot_thing" "air-pollution" {
  name            = "air-pollution"
  thing_type_name = "pollution"
}

resource "aws_iot_certificate" "air-pollution" {
  active = true
}

resource "local_file" "certificate_pem" {
  content  = aws_iot_certificate.air-pollution.certificate_pem
  filename = var.file_crt
}

resource "local_file" "public_key" {
  content  = aws_iot_certificate.air-pollution.public_key
  filename = var.public_key
}

resource "local_file" "private_key" {
  content  = aws_iot_certificate.air-pollution.private_key
  filename = var.private_key
}

resource "aws_iot_thing_principal_attachment" "air-pollution" {
  principal = aws_iot_certificate.air-pollution.arn
  thing     = aws_iot_thing.air-pollution.name
}

resource "aws_iot_policy_attachment" "patt_air-pollution" {
  policy = aws_iot_policy.air-pollution_pubsub.name
  target = aws_iot_certificate.air-pollution.arn
}
