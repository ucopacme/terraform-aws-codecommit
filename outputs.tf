output "repository_id" {
  description = "The ID of the repository"
  value       = aws_codecommit_repository.this.repository_id
}

output "arn" {
  description = "The ARN of the repository"
  value       = aws_codecommit_repository.this.arn
}

output "clone_url_http" {
  description = "The URL to use for cloning the repository over HTTPS."
  value       = aws_codecommit_repository.this.clone_url_http
}

output "clone_url_ssh" {
  description = "The URL to use for cloning the repository over SSH."
  value       = aws_codecommit_repository.this.clone_url_ssh
}

output "name" {
  description = "The name for the repository"
  value       = var.repository_name
}

output "cross_account_role_arn" {
  value = var.repo_cross_account_role_name != "" ? aws_iam_role.cross_account[0].arn : null
}
