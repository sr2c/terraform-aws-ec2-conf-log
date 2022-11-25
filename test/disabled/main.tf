
provider "aws" {
  region = "us-east-2"
}

module "conf_log" {
  source = "./../.."
  name = "enabled"
  enabled = false
}
