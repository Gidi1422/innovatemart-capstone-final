# 1. Mandatory Tagging (Requirement 1)
# (Handled in provider.tf default_tags)

# 2. Developer IAM User & Keys (Requirement 4.3)
resource "aws_iam_user" "dev_user" {
  name = "bedrock-dev-view"
}

resource "aws_iam_user_policy_attachment" "dev_readonly" {
  user       = aws_iam_user.dev_user.name
  # FIXED: Corrected ARN with the double colon (iam::aws)
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
  depends_on = [aws_lambda_permission.allow_s3]
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.asset_processor.function_name
  principal     = "s3.amazonaws.com"
  # Linked to the bucket ARN defined in s3_lambda.tf
  source_arn    = aws_s3_bucket.assets.arn
}