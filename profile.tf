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

data "aws_iam_policy_document" "send_logs_to_cloudwatch" {
  count = var.log_groups_root != null ? 1 : 0
  statement {
    sid = "AllowCloudwatchLogsList"
    actions = [
      "logs:DescribeLogGroups",
    ]

    resources = [
      "arn:aws:logs:${local.region}:${local.account_id}:log-group*"
    ]
  }
  statement {
    sid = "AllowCloudwatchLogsAccess"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "arn:aws:logs:${local.region}:${local.account_id}:log-group:${var.log_groups_root}*"
    ]
  }
}

resource "aws_iam_policy" "send_logs_to_cloudwatch" {
  count       = var.log_groups_root != null ? 1 : 0
  name        = "cloudwatch-logs-${module.this.id}"
  description = "Policy that allows instance to send logs to cloudwatch"
  policy      = data.aws_iam_policy_document.send_logs_to_cloudwatch[0].json
  tags        = module.this.tags
}

resource "aws_iam_role_policy_attachment" "send_logs_to_cloudwatch" {
  count      = var.log_groups_root != null ? 1 : 0
  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.send_logs_to_cloudwatch[0].arn
}

resource "aws_iam_instance_profile" "this" {
  count = local.enabled ? 1 : 0
  name  = module.this.id
  role  = aws_iam_role.this[0].name
}
