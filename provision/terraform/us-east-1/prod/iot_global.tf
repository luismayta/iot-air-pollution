/*
 * IOT global configuration
 */

resource "aws_iot_thing_type" "air-pollution" {
  name = "air-pollution"
}

resource "aws_iot_policy" "air-pollution_pubsub" {
  name = "Air-PollutionPubSub"

  policy = <<EOF
{
        "Version": "2012-10-17",
        "Statement": [ {
            "Action": ["iot:*"],
            "Effect": "Allow",
            "Resource": "*"
            }
        ]
}
EOF
}

resource "aws_iam_role" "air-pollution_iot_iam_role" {
  name = "air-pollution_iot_iam_role"

  assume_role_policy = <<EOF
{
        "Version": "2012-10-17",
        "Statement": [{
            "Effect": "Allow",
            "Principal": {
                "Service": "iot.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }]
}
EOF
}

resource "aws_iam_role_policy" "air-pollution_iot_iam_role_policy" {
  name = "air-pollution_iot_iam_role_policy"
  role = aws_iam_role.air-pollution_iot_iam_role.id

  policy = <<EOF
{
        "Version": "2012-10-17",
        "Statement": [{
            "Effect": "Allow",
            "Action": [
                "sqs:SendMessage"
            ],
            "Resource": "*"
        }]
}
EOF
}

resource "aws_iot_topic_rule" "air_pollution_sensor_rule" {
  name        = "air_pollution_sensor_rule"
  description = "MQTT topic for air pollution sensor messages"
  enabled     = true
  sql         = "SELECT * FROM 'air-pollution/events'"
  sql_version = "2016-03-23"

  sqs {
    queue_url  = "https://sqs.us-east-1.amazonaws.com/756579151825/air-pollution_queue"
    role_arn   = aws_iam_role.air-pollution_iot_iam_role.arn
    use_base64 = false
  }
}
