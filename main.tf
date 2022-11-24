locals {
  enabled = module.this.enabled

  configuration_bucket_enabled = module.this.enabled && !var.disable_configuration_bucket
  logs_bucket_enabled          = module.this.enabled && !var.disable_logs_bucket
  ssm_enabled                  = module.this.enabled && !var.disable_ssm
}