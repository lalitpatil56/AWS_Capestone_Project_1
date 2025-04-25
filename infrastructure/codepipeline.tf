/*
resource "aws_codepipeline" "frontend_pipeline" {
  name     = "webapp-frontend-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = "s3frontendbuild1"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
    name             = "Source"
    category         = "Source"
    owner            = "AWS"
    provider         = "CodeStarSourceConnection"
    version          = "1"
    output_artifacts = ["source_output"]

    configuration = {
      ConnectionArn = "arn:aws:codeconnections:us-east-1:897729119076:connection/d681fa87-8636-4dbf-88ac-549a329a62d3"
      FullRepositoryId = "lalitpatil56/AWS_Capestone_Project_1"
      BranchName       = "main"
      DetectChanges    = "true"
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
        ProjectName = aws_codebuild_project.frontend_build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "DeployToS3"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        BucketName = "s3frontendbuild1"
        Extract    = "true"
      }
    }
  }
  
}
*/
resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline_service_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "codepipeline.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}



############################


resource "aws_codepipeline" "webapp_pipeline" {
  name     = "webapp-ci-cd-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn
  artifact_store {
    location = "s3frontendbuild1"
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
       ConnectionArn = "arn:aws:codeconnections:us-east-1:897729119076:connection/d681fa87-8636-4dbf-88ac-549a329a62d3"
      FullRepositoryId = "lalitpatil56/AWS_Capestone_Project_1"
      BranchName       = "main"
      DetectChanges    = "true"
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "BuildAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"
      configuration = {
        ProjectName = aws_codebuild_project.frontend_build.name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "DeployToEC2"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      version         = "1"
      configuration = {
        ApplicationName     = aws_codedeploy_app.webapp.name
        DeploymentGroupName = aws_codedeploy_deployment_group.webapp_group.deployment_group_name
      }
    }
  }
}
