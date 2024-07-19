resource "aws_iam_openid_connect_provider" "default" {
  url = var.provider_url

  client_id_list = [
    var.audience,
  ]

  thumbprint_list = [var.thumbprint]
}

module "iam_assumable_role_inline_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = var.name

  tags = {
    Role = var.name
  }

  provider_url = var.provider_url

  oidc_fully_qualified_audiences = [var.audience]
  oidc_fully_qualified_subjects = [resource.aws_iam_openid_connect_provider.default.arn]

  inline_policy_statements = [
    {
      sid = "AllowS3Sync"
      actions = [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucketMultipartUploads",
        "s3:AbortMultipartUpload"
      ]
      effect    = "Allow"
      resources = ["*"]
    },
    {
      sid = "AllowCFInvalidate"
      actions = [
        "cloudfront:UpdateDistribution",
        "cloudfront:DeleteDistribution",
        "cloudfront:CreateInvalidation"
      ]
      effect    = "Allow"
      resources = ["*"]
    }
  ]
}