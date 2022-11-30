
provider "aws" {
  region = "us-east-2"
}

module "conf_log" {
  source = "./../.."
  name = "enabled"
  enabled = var.enabled
  disable_configuration_bucket = var.config_disabled
  disable_logs_bucket =  var.log_disabled
  disable_ssm = var.ssm_disabled
}

variable "enabled" {
  type = bool
}

variable "config_disabled" {
  type = bool
}

variable "log_disabled" {
  type = bool
}

variable "ssm_disabled" {
  type = bool
}