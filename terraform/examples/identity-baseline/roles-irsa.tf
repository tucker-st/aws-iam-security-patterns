resource "aws_iam_role" "workload_irsa" {
  name = "workload-irsa-app"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowEKSServiceAccountAssumeRole"
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            # Bind to a single service account identity
            "${var.oidc_provider_url}:sub" = "system:serviceaccount:${var.k8s_namespace}:${var.k8s_service_account}"
            # Optional hardening: ensure correct audience
            "${var.oidc_provider_url}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "workload_minimal_policy" {
  name        = "workload-irsa-minimal-policy"
  description = "Minimal example workload policy (placeholder)."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowOnlyWhatIsRequired"
        Effect = "Allow"
        Action = [
          "sts:GetCallerIdentity"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "workload_attach_minimal" {
  role       = aws_iam_role.workload_irsa.name
  policy_arn = aws_iam_policy.workload_minimal_policy.arn
}
