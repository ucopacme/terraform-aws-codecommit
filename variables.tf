# General vars
variable "repository_name" {
  description = "The name for the repository. This needs to be less than 100 characters."
  type        = string
}

variable "description" {
  description = "The description of the repository. This needs to be less than 1000 characters"
  type        = string
  default     = "codecommit Repo"
}

variable "default_branch" {
  description = "The default branch of the repository. The branch specified here needs to exist."
  type        = string
  default     = null
}

variable "repo_allowed_aws_account_ids" {
  type        = list(string)
  description = "(Optional) list of other AWS account IDs that will be allowed to assume repo_cross_account_role_name"
  default     = []
}

variable "repo_cross_account_role_name" {
  type        = string
  description = "Name of IAM role created for cross account access to repo"
  default     = ""
}

variable "cross_account_kms_key_arns" {
  type        = list(string)
  description = "(Optional) list of KMS key ARNs that repo_cross_account_role_name should be allowed to access"
  default     = []
}

variable "cross_account_codepipeline_bucket_names" {
  type        = list(string)
  description = "(Optional) list of CodePipeline buckets in other account(s) that repo_cross_account_role_name will be able to access"
  default     = []
}

variable "tags" {
  default     = {}
  description = "A map of tags to add to all resources"
  type        = map(string)
}
