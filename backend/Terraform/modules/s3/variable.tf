variable "s3_bucket_name" {
  type        = string
  description = "the name of the bucket"
  default     = "website_entryPoint"
}

variable "s3_bucket_website_index_document" {
  type        = string
  description = "the default file for the static website"
  default     = "${path.module}/../../../frontend/posts.html"
}
variable "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  type        = string
}