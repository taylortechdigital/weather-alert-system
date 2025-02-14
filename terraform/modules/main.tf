# VPC Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

# Internet Gateway, Route Table, and Associations (if needed)
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name        = "${var.vpc_name}-igw"
    Environment = var.environment
  }
}

resource "aws_route_table" "public" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.vpc_name}-public-rt"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(module.vpc.public_subnets)
  subnet_id      = module.vpc.public_subnets[count.index]
  route_table_id = aws_route_table.public.id
}

# EKS Cluster Module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  # EKS Addons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  iam_role_arn = aws_iam_role.eks_cluster_role.arn
  
  self_managed_node_groups = {
    blue = {
      instance_type = var.node_instance_type

      min_size      = var.node_min_size
      max_size      = var.node_max_size
      desired_size  = var.node_desired_size
    }
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

# ALB for Frontend Exposure
resource "aws_lb" "frontend_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.alb_sg.id]

  tags = {
    Name        = var.alb_name
    Environment = var.environment
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.alb_name}-sg"
  description = "Security group for the ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
  }
}

# (Optional) CloudFront Distribution for ALB (set count to 0 if not used)
resource "aws_cloudfront_distribution" "frontend_cf" {
  count = 0

  origin {
    domain_name = aws_lb.frontend_alb.dns_name
    origin_id   = "ALB-Frontend"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  comment             = "CloudFront distribution for frontend ALB"

  default_cache_behavior {
    target_origin_id       = "ALB-Frontend"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
# S3 State Bucket
resource "aws_s3_bucket" "tf_state" {
  bucket = "weather-alert-system-state"

  tags = {
    Name        = weather-alert-system-state
    Environment = var.environment
  }
}

# S3 Logs Bucket (for backend logs)
resource "aws_s3_bucket" "logs" {
  bucket = var.logs_bucket_name

  tags = {
    Name        = var.logs_bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_encryption" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# SNS Topic for Alerts
resource "aws_sns_topic" "alert_topic" {
  name = var.sns_topic_name

  tags = {
    Environment = var.environment
  }
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alert_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email_endpoint
}

# CloudWatch Log Group for Backend Logs
resource "aws_cloudwatch_log_group" "backend_logs" {
  name              = "/aws/eks/${var.eks_cluster_name}/backend-logs"
  retention_in_days = 14
}
