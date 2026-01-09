resource "aws_iam_role" "break_glass_recovery" {
  name                 = "break-glass-recovery"
  permissions_boundary = aws_iam_policy.pb_breakglass_recovery.arn

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Allow a trusted principal to assume the role, but require MFA
      {
        Sid    = "RequireMFAForAssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = var.human_trusted_principal_arn
        }
        Action = "sts:AssumeRole"
        Condition = {
          Bool = {
            "aws:MultiFactorAuthPresent" = "true"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "break_glass_recovery_policy" {
  name        = "break-glass-recovery-policy"
  description = "Identity policy for break-glass recovery role (minimal)."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowRecoveryMinimal"
        Effect = "Allow"
        Action = [
          "sts:GetCallerIdentity",
          "iam:Get*",
          "iam:List*",
          "iam:UpdateAssumeRolePolicy",
          "iam:PutRolePolicy",
          "iam:DeleteRolePolicy",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "cloudtrail:DescribeTrails",
          "cloudtrail:GetTrailStatus",
          "cloudtrail:ListTrails",
          "logs:Describe*",
          "logs:Get*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "breakglass_attach_policy" {
  role       = aws_iam_role.break_glass_recovery.name
  policy_arn = aws_iam_policy.break_glass_recovery_policy.arn
}
