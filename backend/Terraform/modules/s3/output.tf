output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_arn
}

output "s3_bucket_domain_name" {
  description = "The domain name of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_bucket_domain_name
}