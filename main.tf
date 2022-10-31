resource "aws_codecommit_repository" "this" {
  repository_name = join("-", [var.repository_name])
  description     = var.description
  default_branch  = var.default_branch

  # Tags
  tags = var.tags

}
