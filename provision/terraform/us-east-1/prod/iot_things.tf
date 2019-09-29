resource "aws_iot_thing" "air-pollution" {
  name            = "air-pollution"
  thing_type_name = "air-pollution"
}

resource "tls_cert_request" "air-pollution" {
  key_algorithm   = "RSA"
  private_key_pem = file(var.private_key)

  subject {
    common_name    = "Air Pollution"
    organization   = "Air Pollution, Inc"
    street_address = ["Kettwiger Str. 20"]
    locality       = "Lima"
    postal_code    = "380000"
    province       = "Lima"
    country        = "Peru"
  }
}

resource "aws_iot_certificate" "cert_air-pollution" {
  csr    = tls_cert_request.air-pollution.cert_request_pem
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
