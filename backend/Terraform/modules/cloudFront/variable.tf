variable "s3_bucket_website_index_document" {
  type        = string
  description = "the default file for the static website"
  default     = "posts.html"
}

variable "aws_cloudfront_origin_access_control_name" {
  type        = string
  description = "the name of aws cloudfront origin access control"
  default     = "site_access"
}

variable "aws_cloudfront_distribution_aliases" {
  type        = string
  description = "aliases for alternate domain"
  default     = "www.entrypoint" # change to the real DNS name 
}

variable "aws_cloudfront_distribution_acm_certificate_arn" {
  type        = string
  description = "acm certificate arn"
  default     = "arn:aws:acm:us-east-1::certificate/" #change for the real acm certificate arn forom the AWS Certificate Manager
}

variable "s3_bucket_bucket_domain_name" {
  description = "The domain name of the S3 bucket"
  type        = string
}

variable "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  type        = string
}