terraform {
  required_version = ">= 1.10"
  # backend "s3" {
  #   bucket         = "weather-alert-system"
  #   key            = "state/terraform.tfstate"
  #   region         = "us-east-1"
  # }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
