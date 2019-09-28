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
