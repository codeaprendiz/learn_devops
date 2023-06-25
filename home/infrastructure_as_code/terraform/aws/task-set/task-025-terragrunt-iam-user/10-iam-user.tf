data "aws_s3_bucket" "test-backup-bucket" {
  bucket = "test-dev-backup-bucket"
}

module "test-backup-bucket-user" {
  source    = "git::https://github.com/cloudposse/terraform-aws-iam-s3-user.git?ref=master"
  namespace = "test"
  stage     = "dev"
  name      = "backup-bucket-admin-user"
  s3_actions = [
    "s3:GetObject",
    "s3:ListBucket",
    "s3:GetBucketLocation"
  ]
  s3_resources = [
    "${data.aws_s3_bucket.test-backup-bucket.arn}/*",
    data.aws_s3_bucket.test-backup-bucket.arn
  ]
}

output "aws-developer-access-key" {
  sensitive   = true
  value = module.test-backup-bucket-user.access_key_id
}

output "aws-developer-secret-key" {
  sensitive   = true
  value = module.test-backup-bucket-user.secret_access_key
}




