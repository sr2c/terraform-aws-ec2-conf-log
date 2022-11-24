## Configuration bucket

module "conf_bucket" {
  source             = "cloudposse/s3-bucket/aws"
  version            = "0.49.0"
  acl                = "private"
  enabled            = local.configuration_bucket_enabled
  versioning_enabled = false
  context            = module.this
  attributes         = ["conf"]
}

data "aws_iam_policy_document" "conf_bucket" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = ["${module.conf_bucket.bucket_arn}/*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [module.conf_bucket.bucket_arn]
  }
}

resource "aws_iam_policy" "conf_bucket" {
  count  = local.configuration_bucket_enabled ? 1 : 0
  name   = "${module.this.id}-read-config-policy"
  policy = data.aws_iam_policy_document.conf_bucket.json
}
