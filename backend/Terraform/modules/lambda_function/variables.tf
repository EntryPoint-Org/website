variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket" {
  description = "The S3 bucket containing the Lambda function code"
  type        = string
  default     = "entrypoint_bucket"
}

variable "s3_key" {
  description = "The S3 key for the Lambda function code"
  type        = string
}

variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "The function handler for the Lambda function"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
  default     = "python3.9"
}

variable "source_code_hash" {
  description = "Base64-encoded SHA256 hash of the Lambda deployment package"
  type        = string
}

variable "environment_variables" {
  description = "A map of environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}
