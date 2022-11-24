
provider "aws" {
  region = "us-east-2"
}

module "conf_log" {
  source = "./../.."
  enabled = false
}
