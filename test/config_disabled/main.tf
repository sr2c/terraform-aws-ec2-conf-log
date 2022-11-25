
provider "aws" {
  region = "us-east-2"
}

module "conf_log" {
  source = "./../.."
  name = "conf-disabled"
  disable_configuration_bucket = true
  disable_logs_bucket = false
  disable_ssm = false
}
