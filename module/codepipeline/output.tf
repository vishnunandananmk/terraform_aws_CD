output "pipeline_id" {
  description = "CodePipeline ID"
  value       = aws_codepipeline.pipeline.id
}

output "pipeline_arn" {
  description = "CodePipeline ARN"
  value       = aws_codepipeline.pipeline.arn
}

