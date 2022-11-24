terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

module "ec2_conf_log" {
  source    = "./.."
  namespace = "eg"
  name      = "ecl"
}


data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  availability_zone = data.aws_availability_zones.available.names[0]
  default_for_az    = true
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "instance" {
  source  = "cloudposse/ec2-instance/aws"
  version = "0.45.0"

  subnet                      = data.aws_subnet.default.id
  vpc_id                      = data.aws_vpc.default.id
  ami                         = data.aws_ami.ubuntu.id
  ami_owner                   = "099720109477"
  assign_eip_address          = true
  associate_public_ip_address = true
  disable_api_termination     = false
  instance_type               = "t3.medium"
  instance_profile            = module.ec2_conf_log.instance_profile_name

  namespace = "eg"
  name      = "ecl"
}
