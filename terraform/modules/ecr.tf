resource "aws_ecr_repository" "backend" {
  name  = "weather-alerts-backend"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

resource "aws_ecr_repository" "frontend" {
  name  = "weather-alerts-frontend"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}
