module "s3_bucket" {
  source                   = "git::https://github.com/cloudposse/terraform-aws-s3-bucket.git?ref=master"
  enabled                  = true
  user_enabled             = true
  versioning_enabled       = false
  allowed_bucket_actions   = ["s3:*"]
  name                     = "backup-bucket"
  stage                    = "dev"
  namespace                = "test"

}

output "aws-s3-bucket-url" {
  sensitive   = true
  value = module.s3_bucket.bucket_domain_name
}

output "aws-admin-access-key" {
  sensitive   = true
  value = module.s3_bucket.access_key_id
}

output "aws-admin-secret-key" {
  sensitive   = true
  value = module.s3_bucket.secret_access_key
}
