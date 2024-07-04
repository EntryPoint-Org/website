module "s3_bucket" {
  source = "./modules/s3"
  cloudfront_distribution_arn   = module.cloudfront.cloudfront_distribution_arn
}

module "cloudfront" {
  source = "./modules/cloudFront"
  s3_bucket_bucket_domain_name = module.s3_bucket.s3_bucket_domain_name
  s3_bucket_id = module.s3_bucket.s3_bucket_id
}
