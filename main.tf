#PROVIDERS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.3.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.aws_region
}

locals {
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

#RESOURCES
resource "aws_key_pair" "pub_key" {
  key_name   = "pub_key"
  public_key = file(var.key_path)

  tags = {
    ManagedBy = "terraform"
  }
}

resource "aws_default_vpc" "default_vpc" {}

resource "aws_security_group" "sg" {
  name        = "default-sg"
  description = "Default security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_default_vpc.default_vpc.id

  tags = local.common_tags
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.pub_key.id

  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = file("${path.cwd}/bootstrap.sh")

  count = var.instance_count

  tags = local.common_tags
}
