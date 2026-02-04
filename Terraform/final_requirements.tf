# 1. Mandatory Tagging (Requirement 1)
# (Handled in provider.tf default_tags)

# 2. Developer IAM User & Keys (Requirement 4.3)
resource "aws_iam_user" "dev_user" {
  name = "bedrock-dev-view"
}

resource "aws_iam_user_policy_attachment" "dev_readonly" {
  user       = aws_iam_user.dev_user.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# This generates the keys for your grading.json and Google Doc
resource "aws_iam_access_key" "dev_key" {
  user = aws_iam_user.dev_user.name
}

# 3. S3 Bucket Trigger for Lambda (Requirement 4.5)
resource "aws_s3_bucket_notification" "bucket_notification" {
  # Linked to the bucket defined in s3_lambda.tf
  bucket = aws_s3_bucket.assets.id 

  lambda_function {
    lambda_function_arn = aws_lambda_function.asset_processor.arn
    events              = ["s3:ObjectCreated:*"]
  }

  # This ensures permissions exist before the notification is attached
  # Updated to match the resource name in s3_lambda.tf
  depends_on = [aws_lambda_permission.allow_bucket]
}

# Note: The lambda_permission is already in s3_lambda.tf, 
# so we don't duplicate it here to avoid name conflicts.
