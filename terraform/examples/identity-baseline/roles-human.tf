resource "aws_iam_role" "human_ops_readonly" {
  name                 = "human-ops-readonly"
  permissions_boundary = aws_iam_policy.pb_human_standard.arn

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowTrustedPrincipalAssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = var.human_trusted_principal_arn
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "human_ops_readonly_policy" {
  name        = "human-ops-readonly-policy"
  description = "Identity policy for human ops role (read-only)."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowOperationalRead"
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "eks:Describe*",
          "eks:List*",
          "cloudtrail:Describe*",
          "cloudtrail:Get*",
          "cloudtrail:List*",
          "logs:Describe*",
          "logs:Get*",
          "logs:FilterLogEvents",
          "logs:StartQuery",
          "logs:GetQueryResults",
          "sts:GetCallerIdentity"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "human_attach_readonly" {
  role       = aws_iam_role.human_ops_readonly.name
  policy_arn = aws_iam_policy.human_ops_readonly_policy.arn
}
