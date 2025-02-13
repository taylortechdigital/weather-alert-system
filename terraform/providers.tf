terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                     = var.aws_region
#   access_key                 = var.use_localstack ? "test" : null
#   secret_key                 = var.use_localstack ? "test" : null
#   s3_use_path_style          = true
#   skip_requesting_account_id = true

#   # Disable credential validation and metadata API checks for LocalStack
#   skip_credentials_validation = var.use_localstack ? true : false
#   skip_metadata_api_check     = var.use_localstack ? true : false
#   insecure                    = var.use_localstack ? true : false

#   dynamic "endpoints" {
#     for_each = var.use_localstack ? [1] : []
#     content {
#       s3         = var.localstack_endpoint
#       lambda     = var.localstack_endpoint
#       eks        = var.localstack_endpoint
#       cloudwatch = var.localstack_endpoint
#       sns        = var.localstack_endpoint
#     }
#   }
}
