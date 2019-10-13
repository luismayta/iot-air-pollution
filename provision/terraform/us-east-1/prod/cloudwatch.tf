resource "aws_cloudwatch_log_group" "air-pollution" {
  name              = "/aws/lambda/air-pollution-prod"
  retention_in_days = 14
}
