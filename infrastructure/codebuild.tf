resource "aws_codebuild_project" "frontend_build" {
  name         = "webapp-frontend-build"
  description  = "Build React frontend and upload to S3"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    environment_variable {
      name  = "S3_BUCKET"
      value = "s3frontendbuild1"
    }
  }

  source {
    type      = "GITHUB"
    location  = "https://github.com/lalitpatil56/AWS_Capestone_Project_1.git"
    buildspec = "frontend/buildspec.yml"
  }

  cache {
    type = "NO_CACHE"
  }
}

resource "aws_iam_role" "codebuild_role" {
  name = "webapp-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}