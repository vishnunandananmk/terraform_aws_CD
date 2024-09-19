provider "aws" {
  region = "ap-south-1"
}

module "codepipeline" {
  source          = "./module/codepipeline"
  github_repo_url = var.github_repo_url
  ecs_cluster     = var.ecs_cluster
  ecs_service     = var.ecs_service
  s3_bucket       = var.s3_bucket
  github_token    = var.github_token
}

