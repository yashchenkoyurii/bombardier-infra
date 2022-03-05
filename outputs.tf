output "instance_ip_address" {
  value = [aws_instance.instance.*.public_ip]
}

output "instance_user" {
  value = "ubuntu"
}
