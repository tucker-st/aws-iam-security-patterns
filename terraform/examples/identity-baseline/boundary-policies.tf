resource "aws_iam_policy" "pb_human_standard" {
  name        = "pb-human-standard"
  description = "Permission boundary for human roles: constrains maximum privileges."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Explicit deny for IAM mutation actions (prevent escalation)
      {
        Sid    = "DenyIAMEscalation"
        Effect = "Deny"
        Action = [
          "iam:Create*",
          "iam:Update*",
          "iam:Delete*",
          "iam:Attach*",
          "iam:Detach*",
          "iam:Put*",
          "iam:Set*",
          "iam:Add*",
          "iam:Remove*",
          "iam:PassRole"
        ]
        Resource = "*"
      },
      # Permit broad read-only across AWS to enable investigation and ops visibility
      {
        Sid    = "AllowReadOnly"
        Effect = "Allow"
        Action = [
          "sts:GetCallerIdentity",
          "iam:Get*",
          "iam:List*",
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
          "logs:StopQuery",
          "logs:GetQueryResults",
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets",
          "s3:ListBucket"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "pb_breakglass_recovery" {
  name        = "pb-breakglass-recovery"
  description = "Permission boundary for break-glass role: constrained elevated recovery."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Deny creation of new IAM users/access keys (reduce irreversible drift)
      {
        Sid    = "DenyUserAndKeyCreation"
        Effect = "Deny"
        Action = [
          "iam:CreateUser",
          "iam:CreateAccessKey",
          "iam:UpdateAccessKey",
          "iam:DeleteAccessKey"
        ]
        Resource = "*"
      },
      # Allow a narrow set of actions typically needed for recovery (example set)
      {
        Sid    = "AllowRecoveryActions"
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
          "iam:PassRole",
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
