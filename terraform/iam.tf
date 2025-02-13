resource "aws_iam_role" "eks_role" {
  count = var.use_localstack ? 0 : 1
  name  = "eks-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "eks.amazonaws.com" }
    }]
  })
}
