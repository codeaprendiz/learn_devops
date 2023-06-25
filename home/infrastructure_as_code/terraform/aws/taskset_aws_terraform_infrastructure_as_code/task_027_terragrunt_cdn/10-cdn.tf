module "cf-s3-test" {
  source    = "git::https://github.com/cloudposse/terraform-aws-cloudfront-s3-cdn.git?ref=0.41.0"
  namespace = "backend"
  stage     = "dev"
  name      = "test"

## If you want to create alias name for accessing objects cached by cloud front. Note you will need to create the CNAME yourself.
//  aliases = [
//    "test-test-dev.ankitrathi.info"
//  ]
  wait_for_deployment = false
  compress            = true
  ipv6_enabled        = true

  parent_zone_id           = var.public_hosted_zone_id
  acm_certificate_arn      = var.private_certificate_arn
  use_regional_s3_endpoint = true
  origin_force_destroy     = true
  cors_allowed_headers = [
    "*"
  ]
  cors_allowed_methods = [
    "GET",
    "HEAD",
    "PUT"
  ]
  logging_enabled = false


  min_ttl     = 86400
  default_ttl = 604800
  max_ttl     = 31536000

}

resource "aws_s3_bucket_object" "cf-s3-test" {
  bucket       = module.cf-s3-test.s3_bucket
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  etag         = md5(file("${path.module}/index.html"))
}


module "s3-user-test" {
  source    = "git::https://github.com/cloudposse/terraform-aws-iam-s3-user.git?ref=0.14.1"
  namespace = "backend"
  stage     = "dev"
  name      = "test"
  s3_actions = [
    "s3:GetBucketLocation",
    "s3:ListAllMyBuckets",
    "s3:ListBucket",
    "s3:PutObject",
    "s3:PutObjectAcl",
    "s3:GetObjectAcl",
    "s3:GetObjectVersion",
    "s3:DeleteObject",
    "s3:DeleteObjectVersion"
  ]
  s3_resources = [
    module.cf-s3-test.s3_bucket_arn,
    "${module.cf-s3-test.s3_bucket_arn}/*",
  ]

  depends_on = [
    module.cf-s3-test
  ]
}

output "cf-s3-test-name" {
  value = module.cf-s3-test.s3_bucket
}

output "cf-s3-test-domain-name" {
  value = module.cf-s3-test.s3_bucket_domain_name
}

output "s3-user-test-username" {
  value = module.s3-user-test.user_name
}

output "s3-user-test-access-id" {
  sensitive = true
  value = module.s3-user-test.access_key_id
}

output "s3-user-test-secret-key" {
  sensitive = true
  value = module.s3-user-test.secret_access_key
}
