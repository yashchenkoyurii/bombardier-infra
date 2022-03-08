output "bombardier_ssh" {
  value = [
    for ip in values(module.ec2_bombardier)[*].public_ips : format(
      "ssh -i %s %s@%s", replace(var.key_path, ".pub", ""), var.instance_user, ip
    )
  ]
}

output "db1000n_ssh" {
  value = [
    for ip in values(module.ec2_db100n)[*].public_ips : format(
      "ssh -i %s %s@%s", replace(var.key_path, ".pub", ""), var.instance_user, ip
    )
  ]
}
