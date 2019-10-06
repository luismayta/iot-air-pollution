output "aws_iot_thing_id" {
  description = "id aws iot thing"
  value       = aws_iot_thing.air-pollution.default_client_id
}

output "aws_iot_thing_arn" {
  description = "arn aws iot thing"
  value       = aws_iot_thing.air-pollution.arn
}

output "aws_iot_topic_rule_id" {
  description = "id aws iot topic"
  value       = aws_iot_topic_rule.air_pollution_sensor_rule.id
}

output "aws_iot_topic_rule_arn" {
  description = "arn aws iot topic"
  value       = aws_iot_topic_rule.air_pollution_sensor_rule.arn
}

output "aws_sqs_queue_air_pollution_id" {
  description = "id aws_sqs_queue_air_pollution"
  value       = aws_sqs_queue.air-pollution_queue.id
}

output "aws_sqs_queue_air_pollution_arn" {
  description = "arn aws_sqs_queue_air_pollution"
  value       = aws_sqs_queue.air-pollution_queue.arn
}

output "aws_iot_certificate_air-pollution_idn" {
  description = "id air pollution"
  value       = aws_iot_certificate.air-pollution.id
}

output "aws_iot_certificate_air-pollution_arn" {
  description = "arn air pollution"
  value       = aws_iot_certificate.air-pollution.arn
}

output "aws_iot_certificate_air-pollution_certificate_pem" {
  description = "certificate pem air pollution"
  value       = aws_iot_certificate.air-pollution.certificate_pem
}

output "aws_iot_certificate_air-pollution_public_key" {
  description = "public key air pollution"
  value       = aws_iot_certificate.air-pollution.public_key
}

output "aws_iot_certificate_air-pollution_private_key" {
  description = "private key air pollution"
  value       = aws_iot_certificate.air-pollution.private_key
}

output "db_public_ip" {
  description = "public ip server db"
  value       = aws_instance.db.public_ip
}

output "db_private_ip" {
  description = "private ip server db"
  value       = aws_instance.db.private_ip
}

output "aws_eip" {
  description = "eip public"
  value       = aws_eip.eip.public_ip
}
