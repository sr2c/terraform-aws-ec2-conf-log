
provider "aws" {
  region = "us-east-2"
}

module "conf_log" {
  source = "./../.."
  name = "ssm-disabled"
  disable_logs_bucket = false
  disable_configuration_bucket = false
  disable_ssm = true
}
