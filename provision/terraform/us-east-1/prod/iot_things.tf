/*
 * IOT things configuration
 */

resource "aws_iot_thing" "air-pollution" {
  name            = "air-pollution"
  thing_type_name = "air-pollution"
}

resource "aws_iot_certificate" "cert_air-pollution" {
  # csr    = file("/keybase/private/luismayta/pem/terraform-iot-air-pollution-prod.pem")
  active = true
}

resource "aws_iot_thing_principal_attachment" "att_air-pollution" {
  principal = aws_iot_certificate.cert_air-pollution.arn
  thing     = aws_iot_thing.air-pollution.name
}

resource "aws_iot_policy_attachment" "patt_air-pollution" {
  policy = aws_iot_policy.air-pollution_pubsub.name
  target = aws_iot_certificate.cert_air-pollution.arn
}
