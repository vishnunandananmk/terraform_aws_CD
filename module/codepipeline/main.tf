provider "aws" {
  region = var.region
}

# IAM Role for CodeBuild
resource "aws_iam_role" "codebuild_role" {
  name = var.codebuild_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        "Service": [
		"codepipeline.amazonaws.com",
		"codebuild.amazonaws.com"
	]
      }
    }]
  })
}

# Attach policies to the role for S3, ECR, and ECS access
resource "aws_iam_role_policy_attachment" "codebuild_s3_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "codebuild_ecr_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "codebuild_ecs_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

# S3 bucket for storing artifacts
resource "aws_s3_bucket" "artifact_bucket" {
  bucket = var.s3_bucket
  acl    = "private"
}

# CodeBuild project
resource "aws_codebuild_project" "codebuild" {
  name          = "my-codebuild-project"
  service_role  = aws_iam_role.codebuild_role.arn  # Reference the IAM role

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
  }

  source {
    type            = "GITHUB"
    location        = var.github_repo_url
    git_clone_depth = 1
  }

  artifacts {
    type     = "S3"
    location = aws_s3_bucket.artifact_bucket.bucket
  }

  build_timeout = 5
}

# CodePipeline resource
resource "aws_codepipeline" "pipeline" {
  name     = "my-codepipeline"
  role_arn = aws_iam_role.codebuild_role.arn

  artifact_store {
    location = aws_s3_bucket.artifact_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = var.github_owner
        Repo       = var.github_repo_name
        Branch     = var.github_branch
        OAuthToken = var.github_token
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.codebuild.name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ClusterName = var.ecs_cluster
        ServiceName = var.ecs_service
      }
    }
  }
}

output "pipeline_id" {
  value = aws_codepipeline.pipeline.id
}

output "pipeline_arn" {
  value = aws_codepipeline.pipeline.arn
}

