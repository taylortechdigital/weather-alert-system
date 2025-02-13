variable "use_localstack" {
  description = "Set to true to deploy to LocalStack (local development); false for production AWS deployment."
  type        = bool
  default     = false
}

variable "aws_region" {
  description = "AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "logs_bucket_name" {
  description = "S3 bucket name for storing logs (AWS only)."
  type        = string
  default     = "weather-alerts-logs"
}

variable "sns_email_endpoint" {
  description = "Email endpoint for SNS topic subscription (production only)."
  type        = string
  default     = "taylortechdigital@gmail.com"
}

variable "localstack_endpoint" {
  description = "The LocalStack endpoint URL (assumed the same for all services)."
  type        = string
  default     = "http://127.0.0.1:4566"
}

variable "default_availability_zones" {
  description = "Default availability zones to use in LocalStack mode."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB serving the frontend."
  type        = string
  default     = ""  # Replace with your ALB DNS name or leave empty for manual input.
}
