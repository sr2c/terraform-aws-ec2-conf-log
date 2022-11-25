
provider "aws" {
  region = "us-east-2"
}

module "conf_log" {
  source = "./../.."
  name = "log-disabled"
  disable_logs_bucket = true
  disable_configuration_bucket = false
  disable_ssm = false
}
