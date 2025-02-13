resource "aws_sns_topic" "alert_topic" {
  count = var.use_localstack ? 0 : 1
  name  = "weather-alerts-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  count     = var.use_localstack ? 0 : 1
  topic_arn = aws_sns_topic.alert_topic[0].arn
  protocol  = "email"
  endpoint  = var.sns_email_endpoint
}
