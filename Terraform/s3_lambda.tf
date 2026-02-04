# --- Lambda Archive Preparation ---
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambda/index.py"
  output_path = "${path.module}/lambda_function.zip"
}

# 1. The S3 Bucket (Requirement 4.5)
resource "aws_s3_bucket" "assets" {
  bucket        = "bedrock-assets-soe-025-0202" # Hardcoded to match your trigger file
  force_destroy = true
  tags          = { Project = "Bedrock" }
}

# 2. The Lambda Function (Requirement 4.5)
# Renamed to "asset_processor" to match your final_requirements.tf
resource "aws_lambda_function" "asset_processor" {
  filename         = data.archive_file.lambda_zip.output_path 
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  
  function_name    = "bedrock-asset-processor"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "python3.9"
  tags             = { Project = "Bedrock" }
}

# --- Note: Notification and Permissions moved to final_requirements.tf to avoid duplicates ---

# 3. The IAM Role for the Lambda
resource "aws_iam_role" "lambda_role" {
  name = "bedrock-lambda-role-soe-025-0202"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
  tags = { Project = "Bedrock" }
}

# 4. Basic Execution Policy
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}