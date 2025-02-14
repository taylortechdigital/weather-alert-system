variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "development"
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  default     = "weather-alerts-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "eks_cluster_name" {
  description = "Name for the EKS cluster"
  type        = string
  default     = "weather-alerts-cluster"
}

variable "eks_cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "Key pair name for SSH access to worker nodes"
  type        = string
  default     = "my-key"
}

variable "alb_name" {
  description = "Name for the Application Load Balancer"
  type        = string
  default     = "weather-alerts-alb"
}

variable "logs_bucket_name" {
  description = "Name for the S3 logs bucket (for backend logs)"
  type        = string
  default     = "weather-alerts-logs-bucket"
}

variable "sns_topic_name" {
  description = "Name for the SNS topic for alerts"
  type        = string
  default     = "weather-alerts-topic"
}

variable "sns_email_endpoint" {
  description = "Email endpoint for SNS topic subscription (production only)."
  type        = string
  default     = "taylortechdigital@gmail.com"
}
