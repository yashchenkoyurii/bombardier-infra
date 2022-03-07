output "vpc_id" {
  value = aws_default_vpc.vpc.id
}

output "security_group_ids" {
  value = [aws_security_group.sg.id]
}
