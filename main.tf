provider "aws" {
  region = var.region
}

module "codepipeline" {
  source              = "./module/codepipeline"
  
  region              = var.region
  codebuild_role_name = var.codebuild_role_name
  s3_bucket           = var.s3_bucket
  github_repo_url     = var.github_repo_url
  github_owner        = var.github_owner
  github_repo_name    = var.github_repo_name
  github_branch       = var.github_branch
  github_token        = var.github_token
  ecs_cluster         = var.ecs_cluster
  ecs_service         = var.ecs_service
}

