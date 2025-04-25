resource "aws_codedeploy_app" "webapp" {
  name = "webapp-deploy"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "webapp_group" {
  app_name              = aws_codedeploy_app.webapp.name
  deployment_group_name = "webapp-deployment-group"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  autoscaling_groups = [aws_autoscaling_group.webapp_asg.name]

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "webapp-instance"
    }
  }

  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.webapp_tg.name
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}

resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "codedeploy.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_attach" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AdministratorAccess"
}