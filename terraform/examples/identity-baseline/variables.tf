variable "aws_region" {
  type        = string
  description = "AWS region for the example."
  default     = "us-east-1"
}

# Human access assumptions:
# - In production you should use federated principals from AWS IAM Identity Center / SAML OIDC.
# - For this example we keep the trust policy generic with placeholders.
variable "human_trusted_principal_arn" {
  type        = string
  description = "ARN of the principal allowed to assume the human role (e.g., an SSO role ARN)."
}

# IRSA assumptions:
variable "oidc_provider_arn" {
  type        = string
  description = "ARN of the EKS OIDC provider."
}

variable "oidc_provider_url" {
  type        = string
  description = "EKS OIDC issuer URL, without the https:// prefix (e.g., oidc.eks.<region>.amazonaws.com/id/XXXX)."
}

variable "k8s_namespace" {
  type        = string
  description = "Kubernetes namespace for IRSA binding."
  default     = "default"
}

variable "k8s_service_account" {
  type        = string
  description = "Kubernetes service account name for IRSA binding."
  default     = "app-sa"
}

# Break-glass assumptions:
variable "break_glass_mfa_serial_arn" {
  type        = string
  description = "MFA device serial ARN required to assume break-glass role."
}
