resource "aws_instance" "instance" {
  ami           = var.instance_ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_id

  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.instance_root_device_size
    volume_type = "gp3"
  }

  user_data = var.user_data

  tags = var.common_tags
}
