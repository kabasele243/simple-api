variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "container_cpu" {
  description = "Container CPU units"
  type        = number
}

variable "container_memory" {
  description = "Container memory"
  type        = number
}

variable "desired_count" {
  description = "Desired count of tasks"
  type        = number
}

variable "min_capacity" {
  description = "Minimum capacity for auto scaling"
  type        = number
}

variable "max_capacity" {
  description = "Maximum capacity for auto scaling"
  type        = number
}