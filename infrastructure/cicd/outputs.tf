output "codepipeline_name" {
  value = aws_codepipeline.codepipeline.name
}

output "artifact_bucket_name" {
  value = aws_s3_bucket.final_build_artifacts.bucket
}