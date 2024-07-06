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
    VAR1 = "value1"
    VAR2 = "value2"
  }
  source_code_hash      = data.archive_file.lambda_function_1.output_base64sha256
}

