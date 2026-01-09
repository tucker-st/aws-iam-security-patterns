output "human_ops_role_arn" {
  value = aws_iam_role.human_ops_readonly.arn
}

output "workload_irsa_role_arn" {
  value = aws_iam_role.workload_irsa.arn
}

output "break_glass_role_arn" {
  value = aws_iam_role.break_glass_recovery.arn
}
