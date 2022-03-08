#PROVIDERS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.3.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.aws_region
}

locals {
  external_ip = jsondecode(data.http.my_public_ip.body)
  vpn_files   = tolist(fileset("${path.cwd}/ovpn", "*.ovpn"))


  common_tags = {
    ManagedBy = "terraform"
  }
}

#DATA SOURCES
data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"]
}

data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

module "key_pair" {
  source   = "./modules/key_pair"
  key_path = var.key_path
}

module "vpc" {
  source = "./modules/vpc"
}

module "ovpn_bombardier" {
  source        = "./modules/random"
  max_number    = length(local.vpn_files) - 1
  numbers_count = length(var.targets)
}

module "ovpn_db1000n" {
  source        = "./modules/random"
  max_number    = length(local.vpn_files) - 1
  numbers_count = var.db1000n_count
}

module "ec2_bombardier" {
  source = "./modules/ec2"

  for_each = toset(var.targets)

  user_data = templatefile("${path.cwd}/bootstraps/bombardier.tftpl", {
    external_ip : lookup(local.external_ip, "ip"),
    open_vpn : file(format(
      "%s/ovpn/%s",
      path.cwd,
      local.vpn_files[module.ovpn_bombardier.numbers[index(var.targets, each.key)]]
    )),
    duration : var.duration,
    target : each.value,
    user : var.instance_user
  })

  instance_ami_id    = data.aws_ami.ami.id
  instance_type      = var.instance_type
  security_group_ids = module.vpc.security_group_ids
  key_pair_id        = module.key_pair.key_pair_id
}

module "ec2_db100n" {
  source = "./modules/ec2"

  for_each = toset([for i in range(var.db1000n_count) : tostring(i)])

  user_data = templatefile("${path.cwd}/bootstraps/db1000n.tftpl", {
    external_ip : lookup(local.external_ip, "ip"),
    open_vpn : file(format(
      "%s/ovpn/%s",
      path.cwd,
      local.vpn_files[module.ovpn_db1000n.numbers[each.key]]
    )),
    user : var.instance_user
  })

  instance_type      = var.instance_type
  security_group_ids = module.vpc.security_group_ids
  instance_ami_id    = data.aws_ami.ami.id
  key_pair_id        = module.key_pair.key_pair_id
}
