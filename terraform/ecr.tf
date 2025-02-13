resource "aws_ecr_repository" "backend" {
  count = var.use_localstack ? 0 : 1
  name  = "weather-alerts-backend"
}

resource "aws_ecr_repository" "frontend" {
  count = var.use_localstack ? 0 : 1
  name  = "weather-alerts-frontend"
}
