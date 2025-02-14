output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}

output "eks_cluster_id" {
  description = "The EKS cluster ID"
  value       = module.eks.cluster_id
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.frontend_alb.dns_name
}

output "logs_bucket" {
  description = "The S3 logs bucket name"
  value       = aws_s3_bucket.logs.bucket
}

output "sns_topic_arn" {
  description = "The SNS topic ARN"
  value       = aws_sns_topic.alert_topic.arn
}
