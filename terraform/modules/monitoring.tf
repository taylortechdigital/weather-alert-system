resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  timeout    = 600
  cleanup_on_fail = true 

  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }
  
  set {
    name = "prometheus-pushgateway.enabled"
    value = false
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  timeout    = 600
  cleanup_on_fail = true

  set {
    name  = "persistence.enabled"
    value = false
  }

  set {
    name  = "adminPassword"
    value = "your_admin_password"  # TODO: replace with a secure value or reference a secret
  }
}

resource "aws_cloudwatch_metric_alarm" "severe_weather_alarm" {
  alarm_name          = "SevereWeatherAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "SevereWeatherEvents"
  namespace           = "WeatherMonitoring"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "Triggers when severe weather events exceed threshold"
  alarm_actions       = [aws_sns_topic.alert_topic.arn]
}
