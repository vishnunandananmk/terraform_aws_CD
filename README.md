# Terraform AWS CodePipeline for ECS Deployment

This repository contains Terraform scripts to set up an AWS CodePipeline that automates the deployment of a Dockerized application to Amazon ECS (Elastic Container Service). It integrates with GitHub for source control and AWS CodeBuild for building Docker images, enabling CI/CD (Continuous Integration and Continuous Deployment) for modern applications.

## Table of Contents

- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Usage](#usage)
- [Variables](#variables)
- [Outputs](#outputs)
- [License](#license)

## Project Structure

. ├── main.tf # Root configuration file ├── terraform.tfvars # Variable values for Terraform └── module └── codepipeline # Module for CodePipeline setup ├── main.tf # Main configuration for the CodePipeline ├── variables.tf # Variables used by the CodePipeline module └── outputs.tf # Outputs from the CodePipeline module

markdown
Copy code

## Prerequisites

Before you begin, ensure you have the following:

- **AWS Account**: Ensure you have the necessary IAM permissions.
- **AWS CLI**: Installed and configured with access to your account.
- **Terraform**: Installed (version 1.x recommended).
- **GitHub Repository**: Contains your Dockerized application.
- Proper IAM roles and policies configured for AWS services used.

## Setup

1. **Clone the repository**:

   ```bash
   git clone https://github.com/your-repo-name.git
   cd your-repo-name
Create a terraform.tfvars file in the root directory to specify your environment variables. Below is an example:

hcl
Copy code
region              = "ap-south-1"
codebuild_role_name = "codebuild-service-role"
s3_bucket           = "my-artifact-bucket-223647876635"
github_repo_url     = "https://github.com/your-username/your-repo.git"
github_owner        = "your-username"
github_repo_name    = "your-repo"
github_branch       = "main"
github_token        = "your-github-token"
ecs_cluster         = "your-ecs-cluster-name"
ecs_service         = "your-ecs-service-name"
ecs_container_name  = "your-ecs-container-name"
Initialize Terraform:

bash
Copy code
terraform init
Validate your configuration:

bash
Copy code
terraform validate
Apply the configuration:

bash
Copy code
terraform apply
Review the changes and confirm to proceed.

Usage
Once the configuration is applied, the CodePipeline will automatically trigger on changes to the specified GitHub repository. The pipeline consists of the following stages:

Source Stage: Pulls the latest code from the GitHub repository.
Build Stage: Uses AWS CodeBuild to build the Docker image, push it to Amazon ECR (Elastic Container Registry), and generate the imagedefinitions.json file for ECS deployment.
Deploy Stage: Updates the ECS service with the new Docker image.
Build Specification
The buildspec.yml file defines the build process and specifies how to build and push the Docker image. Ensure the ecs_container_name variable matches the container name defined in your ECS task definition.

Variables
Variable	Description
region	AWS region where resources will be created.
codebuild_role_name	Name of the IAM role for CodeBuild.
s3_bucket	Name of the S3 bucket for storing artifacts.
github_repo_url	URL of the GitHub repository.
github_owner	Owner of the GitHub repository.
github_repo_name	Name of the GitHub repository.
github_branch	Branch of the GitHub repository to use.
github_token	GitHub OAuth token for access.
ecs_cluster	Name of the ECS cluster.
ecs_service	Name of the ECS service to deploy.
ecs_container_name	Name of the container in the ECS task.
Outputs
After running terraform apply, the following outputs will be available:

pipeline_id: The ID of the created CodePipeline.
pipeline_arn: The ARN of the created CodePipeline.
License
This project is licensed under the MIT License - see the LICENSE file for details.
