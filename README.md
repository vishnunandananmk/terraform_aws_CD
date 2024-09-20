# Terraform AWS CodePipeline for Seamless Application Deployment

## OVERVIEW

This Terraform setup provides a streamlined solution to automate the build, storage, and deployment of your application on AWS ECS. While it’s versatile enough for any app, i used a Django application. The entire pipeline is managed through AWS services like CodePipeline, CodeBuild, and ECS, ensuring a smooth and continuous deployment process from GitHub to production.

## KEY FEATURES

- **GITHUB INTEGRATION**: Automatically pulls code from your GitHub repository to initiate the build and deployment.
- **CODEPIPELINE**: Orchestrates the entire CI/CD process.
- **CODEBUILD**: Builds the application and stores artifacts in S3.
- **AMAZON ECR**: Stores the Docker images.
- **AMAZON ECS**: Deploys the latest Docker image to your ECS cluster.
- **PRIVATE S3**: Stores build artifacts securely in a private S3 bucket.
- **CODEDEPLOY**: Manages the deployment and versioning of your application.

## AWS SERVICES UTILIZED

- **AWS CODEPIPELINE**: Automates the build and deployment lifecycle.
- **AWS CODEBUILD**: Compiles and packages the application code.
- **AMAZON S3**: Private storage for build artifacts.
- **AMAZON ECR**: Docker container registry for storing built images.
- **AMAZON ECS**: Elastic container service for deploying the app in Docker containers.
- **AWS CODEDEPLOY**: Manages application versions and deployment strategies.

## PROJECT STRUCTURE

Here’s how the project is structured:
```
root
├── main.tf              # Main Terraform configuration
├── variables.tf         # Variables used across the setup
├── terraform.tfvars     # Optional: Add your environment-specific values here
└───module
    └───codepipeline
        └─── main.tf          # CodePipeline-specific resources
        └─── variables.tf     # Variables for CodePipeline module
```
LICENSE
This project is licensed under the MIT License.
