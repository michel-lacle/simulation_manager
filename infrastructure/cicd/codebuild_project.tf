resource "aws_iam_role" "codebuild" {
  name = "codebuild-${var.deploy_application_name}-${var.branch}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
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

data "aws_iam_policy_document" "codebuild" {

  // allow codebuild to log to cloudwatch
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    effect = "Allow"

    resources = [
      "arn:aws:logs:us-east-1:*:log-group:/aws/codebuild/*",
      "arn:aws:logs:us-east-1:*:log-group:/aws/codebuild/*"
    ]
  }

  // allow codebuild to put artifacts in s3
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]

    effect = "Allow"

    resources = [
      "arn:aws:s3:::*"
    ]
  }

  // allow codebuild to publish test reports
  statement {
    actions = [
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases"
    ]

    effect = "Allow"

    resources = [
      "arn:aws:codebuild:us-east-1:*:report-group/*"
    ]
  }
}

resource "aws_iam_role_policy" "codebuild" {
  role = aws_iam_role.codebuild.name

  policy = data.aws_iam_policy_document.codebuild.json
}

resource "aws_codebuild_project" "application" {
  name = "${var.deploy_application_name}_${var.branch}"
  description = var.deploy_application_name

  # in minutes
  build_timeout = "15"
  service_role = aws_iam_role.codebuild.arn

  source {
    type = "CODEPIPELINE"
  }

  source_version = var.branch

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:4.0"
    type = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    # enable us to run the docker deamon inside a docker container
    privileged_mode = true
  }

  tags = {
    Application = var.application_tag
    Contact = var.contact_tag
    ManagedBy = var.managedby_tag
  }
}