resource "aws_lb" "frontend_alb" {
  count               = var.use_localstack ? 0 : 1
  name                = "weather-alerts-alb"
  load_balancer_type  = "application"
  security_groups     = [aws_security_group.alb_sg[0].id]
  subnets             = aws_subnet.public[*].id

  tags = {
    Name = "weather-alerts-alb"
  }
}
