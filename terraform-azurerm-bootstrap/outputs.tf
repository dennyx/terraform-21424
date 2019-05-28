output "admin_username" {
  description = "SSH User"
  value       = "${module.dcos-bootstrap-instances.admin_username}"
}

output "private_ip" {
  description = "List of private ip addresses created by this module"
  value       = "${module.dcos-bootstrap-instances.private_ips[0]}"
}

output "public_ip" {
  description = "List of public ip addresses created by this module"
  value       = "${module.dcos-bootstrap-instances.public_ips[0]}"
}

output "prereq_id" {
  description = "Prereq id used for dependency"
  value       = "${module.dcos-bootstrap-instances.prereq_id}"
}
