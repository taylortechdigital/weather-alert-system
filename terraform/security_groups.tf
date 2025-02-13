resource "aws_security_group" "alb_sg" {
  count       = var.use_localstack ? 0 : 1
  name        = "weather-alerts-alb-sg"
  description = "Security group for the ALB serving the frontend"
  vpc_id      = aws_vpc.main[0].id

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
    Name = "weather-alerts-alb-sg"
  }
}
