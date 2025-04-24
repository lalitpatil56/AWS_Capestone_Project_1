data "aws_s3_bucket" "frontend_bucket" {
  bucket = "s3frontendbuild1"
}

resource "aws_s3_object" "frontend_files" {
  for_each = fileset("frontend/build", "**")

  bucket = data.aws_s3_bucket.frontend_bucket.bucket
  key    = each.value
  source = "frontend/build/${each.value}"
  acl    = "public-read"
}