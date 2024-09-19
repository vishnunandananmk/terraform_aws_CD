variable "github_repo_url" {
  description = "GitHub repository URL"
  type        = string
}

variable "ecs_cluster" {
  description = "ECS cluster name"
  type        = string
}

variable "ecs_service" {
  description = "ECS service name"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket for storing artifacts"
  type        = string
}

variable "github_token" {
  description = "GitHub OAuth Token"
  type        = string
  sensitive   = true
}

