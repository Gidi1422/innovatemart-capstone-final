# 4.3: IAM User for Developer
resource "aws_iam_user" "dev_user" {
  name = "bedrock-dev-view"
  tags = { Project = "Bedrock" }
}

resource "aws_iam_user_policy_attachment" "read_only" {
  user       = aws_iam_user.dev_user.name
  policy_arn = "arn:aws:iam:aws:policy/ReadOnlyAccess"
}

# 4.4: EKS Control Plane Logging (Add this to your existing aws_eks_cluster resource)
# Note: You should find your 'aws_eks_cluster' resource in your main code and add this line:
# enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

# 4.5: S3 Bucket Notification (Triggers Lambda)
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "bedrock-assets-soe-025-0202" # Ensure this matches your bucket name

  lambda_function {
    lambda_function_arn = aws_lambda_function.asset_processor.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.asset_processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::bedrock-assets-soe-025-0202"
}