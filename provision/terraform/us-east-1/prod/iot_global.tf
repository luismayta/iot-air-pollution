resource "aws_iot_thing_type" "air-pollution" {
  name = "pollution"
}

resource "aws_iot_topic_rule" "air_pollution_sensor_rule" {
  name        = "air_pollution_sensor_rule"
  description = "Kinesis Rule"
  enabled     = true
  sql         = "SELECT * FROM 'topic/${var.topic}'"
  sql_version = "2016-03-23"

  kinesis {
    role_arn      = aws_iam_role.air-pollution.arn
    stream_name   = aws_kinesis_stream.air-pollution.name
    partition_key = "$${newuuid()}"
  }

  firehose {
    delivery_stream_name = aws_kinesis_firehose_delivery_stream.air-pollution.name
    role_arn             = aws_iam_role.air-pollution.arn
  }
}
