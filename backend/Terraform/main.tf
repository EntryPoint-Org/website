module "s3_bucket" {
  source = "./modules/s3"
  cloudfront_distribution_arn   = module.cloudfront.cloudfront_distribution_arn
}

module "cloudfront" {
  source = "./modules/cloudFront"
  s3_bucket_bucket_domain_name = module.s3_bucket.s3_bucket_domain_name
  s3_bucket_id = module.s3_bucket.s3_bucket_id
}

# Define S3 bucket object (source code) for Lambda function
data "aws_s3_bucket_object" "lambda_zip_gda" {
  bucket = var.s3_bucket
  key    = "lamda_functions/google_drive_analytics.zip" #all functions will be stored in the lamda_functions folder inside the bucket
}

module "lambda_function_gda" {
  source = "./modules/lambda_function/lambda"

  s3_bucket             = var.s3_bucket
  s3_key                = data.aws_s3_bucket_object.lambda_zip_gda.key
  function_name         = "google_drive_analytics"
  handler               = "google_drive_analytics.lambda_handler"  # Adjust according to your handler(function file name/handler function name)
  runtime               = "python3.9"
  environment_variables = {
    SECRET_NAME                = locals.secret_name
    REGION_NAME                = var.region
    ENTRYPOINT_DRIVE_FOLDER_ID = "1ugHtUXt1WhRrddKYdw5udTlCVH7lwMu_"
    HOME_TASKS_FOLDER_ID       = "1NF4IZ-GWgZhhE1PWVg8eF7MQ2Vsv8vu9"

  }
}
