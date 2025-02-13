resource "aws_cloudwatch_log_group" "weather_alerts" {
  count             = var.use_localstack ? 0 : 1
  name              = "/aws/lambda/weather-alerts"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_metric_filter" "severe_weather_filter" {
  count          = var.use_localstack ? 0 : 1
  name           = "SevereWeatherFilter"
  log_group_name = aws_cloudwatch_log_group.weather_alerts[0].name
  pattern        = "{ $.event = \"Tornado Warning\" }"

  metric_transformation {
    name      = "SevereWeatherEvents"
    namespace = "WeatherMonitoring"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "severe_weather_alarm" {
  count               = var.use_localstack ? 0 : 1
  alarm_name          = "SevereWeatherAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = aws_cloudwatch_log_metric_filter.severe_weather_filter[0].metric_transformation[0].name
  namespace           = aws_cloudwatch_log_metric_filter.severe_weather_filter[0].metric_transformation[0].namespace
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "Triggers when Tornado Warning logs exceed 10 in one minute."
  alarm_actions       = [aws_sns_topic.alert_topic[0].arn]
}
