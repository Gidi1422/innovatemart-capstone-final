# --- Mandatory Rubric Outputs (Requirement 1 & 6) ---

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "region" {
  description = "The AWS region."
  value       = "us-east-1"
}

output "vpc_id" {
  description = "The ID of the project VPC."
  value       = module.vpc.vpc_id
}

output "assets_bucket_name" {
  description = "The name of the S3 bucket for assets."
  value       = aws_s3_bucket.assets.id
}

# --- Developer Credentials for your Google Doc (Requirement 4.3) ---

resource "aws_iam_access_key" "dev_key" {
  user = aws_iam_user.dev_user.name
}

output "dev_viewer_access_key" {
  description = "Access Key for the bedrock-dev-view user."
  value       = aws_iam_access_key.dev_key.id
}

output "dev_viewer_secret_key" {
  description = "Secret Key for the bedrock-dev-view user."
  value       = aws_iam_access_key.dev_key.secret
  sensitive   = true
}