/*
 * SQS queue configuration
 */

resource "aws_sqs_queue" "air-pollution_queue" {
  name                      = "air-pollution_queue"
  receive_wait_time_seconds = 20
}
