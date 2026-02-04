resource "aws_iam_user_policy_attachment" "dev_readonly" { user = aws_iam_user.dev_user.name; policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess" }
