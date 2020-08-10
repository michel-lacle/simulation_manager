resource "aws_s3_bucket" "codepipeline" {
  # make sure bucket name is dns compliant
  bucket = lower(replace("${var.deploy_application_name}-codepipeline", "_", "-"))
  acl = "private"

  tags = {
    Application = var.application_tag
    Contact = var.contact_tag
    ManagedBy = var.managedby_tag
  }
}

resource "aws_iam_role" "codepipeline" {
  name = "${var.deploy_application_name}_${var.branch}_codepipeline"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Application = var.application_tag
    Contact = var.contact_tag
    ManagedBy = var.managedby_tag
  }
}

resource "aws_iam_role_policy" "codepipeline" {
  name = "${var.deploy_application_name}_${var.branch}_codepipeline"
  role = aws_iam_role.codepipeline.id

  policy = file("${path.module}/codepipeline_iam_policy.json")
}

resource "aws_codepipeline" "codepipeline" {
  name = "${var.deploy_application_name}_${var.branch}"
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline.bucket
    type = "S3"
  }

  stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      owner = "AWS"
      provider = "CodeCommit"
      version = "1"
      output_artifacts = [
        "SourceArtifact"]

      configuration = {
        RepositoryName = var.repository_name
        BranchName = var.branch
        PollForSourceChanges = true
      }

      namespace = "SourceVariables"
    }
  }

  stage {
    name = "Build"

    action {
      name = "Build"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      input_artifacts = [
        "SourceArtifact"]
      output_artifacts = [
        "BuildArtifact"]
      version = "1"

      configuration = {
        ProjectName = aws_codebuild_project.application.name
      }

      namespace = "BuildVariables"
    }
  }

  stage {
    name = "Deploy"

    action {
      name = "S3"
      category = "Deploy"
      owner = "AWS"
      provider = "S3"
      input_artifacts = [
        "BuildArtifact"]
      version = "1"

      configuration = {
        BucketName = aws_s3_bucket.final_build_artifacts.bucket
        Extract = false

        ObjectKey = "${var.branch}/${var.deploy_application_name}-{datetime}--#{SourceVariables.CommitId}.zip"
      }
    }

    action {
      name = "Virtual_Environment"
      category = "Deploy"
      owner = "AWS"
      provider = "CodeDeploy"
      input_artifacts = [
        "BuildArtifact"]
      version = "1"

      configuration = {
        ApplicationName = aws_codedeploy_app.this.name
        DeploymentGroupName = aws_codedeploy_deployment_group.this.deployment_group_name
      }
    }
  }

  tags = {
    Application = var.application_tag
    Contact = var.contact_tag
    ManagedBy = var.managedby_tag
  }
}