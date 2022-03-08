resource "aws_default_vpc" "vpc" {}

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

  vpc_id = aws_default_vpc.vpc.id

  tags = var.common_tags
}
