output "ecr_backend" {
  value = var.use_localstack ? "local" : aws_ecr_repository.backend[0].repository_url
}

output "ecr_frontend" {
  value = var.use_localstack ? "local" : aws_ecr_repository.frontend[0].repository_url
}

output "s3_logs_bucket" {
  value = var.use_localstack ? "local" : aws_s3_bucket.logs[0].bucket
}

output "sns_topic_arn" {
  value = var.use_localstack ? "local" : aws_sns_topic.alert_topic[0].arn
}

output "alb_dns_name" {
  value = aws_lb.frontend_alb[0].dns_name
}