resource "aws_iam_user" "developer" {
  name = "bedrock-dev-view"
  tags = { Project = "Bedrock" }
}

resource "aws_iam_user_policy_attachment" "read_only" {
  user       = aws_iam_user.developer.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_access_key" "dev_key" {
  user = aws_iam_user.developer.name
}

output "dev_access_key" {
  value = aws_iam_access_key.dev_key.id
}

output "dev_secret_key" {
  value     = aws_iam_access_key.dev_key.secret
  sensitive = true
}