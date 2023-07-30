## Logs bucket

module "log_bucket" {
  source             = "cloudposse/s3-bucket/aws"
  version            = "3.1.2"
  acl                = "private"
  enabled            = local.logs_bucket_enabled
  versioning_enabled = false
  context            = module.this
  attributes         = ["logs"]
}

data "aws_iam_policy_document" "log_bucket" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = ["${module.log_bucket.bucket_arn}/*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [module.log_bucket.bucket_arn]
  }
}

resource "aws_iam_policy" "log_bucket" {
  count  = local.logs_bucket_enabled ? 1 : 0
  name   = "${module.this.id}-read-write-logs-policy"
  policy = data.aws_iam_policy_document.log_bucket.json
}
