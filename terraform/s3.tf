resource "aws_s3_bucket" "logs" {
  count  = var.use_localstack ? 0 : 1
  bucket = var.logs_bucket_name
  tags = {
    Name = var.logs_bucket_name
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_encryption" {
  count  = var.use_localstack ? 0 : 1
  bucket = aws_s3_bucket.logs[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
