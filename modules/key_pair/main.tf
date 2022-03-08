resource "aws_key_pair" "pub_key" {
  key_name   = "pub_key"
  public_key = file(var.key_path)

  tags = var.common_tags
}
