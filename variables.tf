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

variable "tags" {
  default     = {}
  description = "A map of tags to add to all resources"
  type        = map(string)
}