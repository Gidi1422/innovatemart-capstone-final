terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # This satisfies Requirement 4.1: Remote State Management
  backend "s3" {
    bucket         = "bedrock-state-alt-soe-025-0202"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = var.region
}