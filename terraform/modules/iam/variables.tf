variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "github_repository" {
  description = "GitHub repository in format owner/repo-name"
  type        = string
}

variable "create_oidc_provider" {
  description = "Whether to create the OIDC provider (true for first environment, false for others)"
  type        = bool
  default     = false
}