resource "aws_iam_role" "ec2_backend_role" {
  name = "webapp-ec2-backend-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}
resource "aws_iam_policy" "ec2_s3_access_policy" {
  name        = "EC2S3ReadAccessForDeploy"
  description = "Allows EC2 to read from deployment bucket"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      Resource = "arn:aws:s3:::capstone1frontend/*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "admin_access" {
  role       = aws_iam_role.ec2_backend_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "attach_s3_read_policy_to_ec2_role" {
  role       = aws_iam_role.ec2_backend_role.name  # Use actual EC2 instance profile role name
  policy_arn = aws_iam_policy.ec2_s3_access_policy.arn
}

resource "aws_iam_policy" "dynamodb_access" {
  name = "webapp-dynamodb-access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:Scan",
        "dynamodb:UpdateItem"
      ],
      Effect   = "Allow",
      Resource = "arn:aws:dynamodb:us-east-1:897729119076:table/UserTable"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_dynamodb_policy" {
  role       = aws_iam_role.ec2_backend_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "webapp-ec2-profile"
  role = aws_iam_role.ec2_backend_role.name
}

resource "aws_iam_role_policy_attachment" "ssm_core_attach" {
  role       = aws_iam_role.ec2_backend_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
