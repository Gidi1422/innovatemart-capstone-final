output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "region" {
  description = "AWS Region"
  value       = "us-east-1"
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "assets_bucket_name" {
  description = "The name of the S3 bucket for assets"
  value       = "bedrock-assets-soe-025-0202"
}

# Credentials for the bedrock-dev-view user (Required for Section 6)
output "dev_viewer_access_key" {
  value = aws_iam_access_key.dev_key.id
}

output "dev_viewer_secret_key" {
  value     = aws_iam_access_key.dev_key.secret
  sensitive = true
}

# Bonus Requirement: RDS Endpoint
output "rds_catalog_endpoint" {
  description = "The connection endpoint for the Catalog RDS"
  value       = aws_db_instance.catalog.endpoint
}