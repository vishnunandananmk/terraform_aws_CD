variable "region" {
  description = "AWS region to deploy the pipeline"
  type        = string
  default     = "ap-south-1"
}

variable "codebuild_role_name" {
  description = "Name of the IAM role for CodeBuild"
  type        = string
  default     = "codebuild-service-role"
}

variable "s3_bucket" {
  description = "S3 bucket for CodeBuild artifacts"
  type        = string
}

variable "github_repo_url" {
  description = "GitHub repository URL"
  type        = string
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "github_repo_name" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to track"
  type        = string
}

variable "github_token" {
  description = "GitHub OAuth token for CodePipeline"
  type        = string
  sensitive   = true
}

variable "ecs_cluster" {
  description = "ECS Cluster name where the service is deployed"
  type        = string
}

variable "ecs_service" {
  description = "ECS Service name to deploy to"
  type        = string
}

