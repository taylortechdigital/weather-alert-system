resource "aws_eks_cluster" "weather_alerts" {
  count    = var.use_localstack ? 0 : 1
  name     = "weather-alerts-cluster"
  role_arn = aws_iam_role.eks_role[0].arn

  vpc_config {
    # Ensure that you have a VPC and subnets created.
    subnet_ids = aws_subnet.public[*].id
  }
}
