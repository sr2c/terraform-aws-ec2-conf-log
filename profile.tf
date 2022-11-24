## IAM Instance Profile

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  count              = local.enabled ? 1 : 0
  name               = module.this.id
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags               = module.this.tags
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  count      = local.ssm_enabled ? 1 : 0
  role       = aws_iam_role.this[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "conf_bucket" {
  count      = local.configuration_bucket_enabled ? 1 : 0
  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.conf_bucket[0].arn
}

resource "aws_iam_role_policy_attachment" "log_bucket" {
  count      = local.logs_bucket_enabled ? 1 : 0
  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.log_bucket[0].arn
}

resource "aws_iam_instance_profile" "this" {
  count = local.enabled ? 1 : 0
  name  = module.this.id
  role  = aws_iam_role.this[0].name
}
