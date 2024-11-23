locals {
  enabled = module.this.enabled

  configuration_bucket_enabled = module.this.enabled && !var.disable_configuration_bucket
  logs_bucket_enabled          = module.this.enabled && !var.disable_logs_bucket
  ssm_enabled                  = module.this.enabled && !var.disable_ssm

  account_id = data.aws_caller_identity.this.account_id
  region     = data.aws_region.current.name
}

data "aws_caller_identity" "this" {}
data "aws_region" "current" {}