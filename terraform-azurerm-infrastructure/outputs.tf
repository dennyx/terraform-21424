# Deployed bootstrap agent SSH user
output "bootstrap.admin_username" {
  description = "Bootstrap node SSH User"
  value       = "${module.bootstrap.admin_username}"
}

# Returns the ID of the prereq script
output "bootstrap.prereq_id" {
  description = "Returns the ID of the prereq script (if image are not used)"
  value       = "${module.bootstrap.prereq_id}"
}

# Deployed masters agent SSH user
output "masters.admin_username" {
  description = "Masters node SSH User"
  value       = "${module.masters.admin_username}"
}

# Returns the ID of the prereq script
output "masters.prereq_id" {
  description = "Returns the ID of the prereq script for masters (if user_data or ami are not used)"
  value       = "${module.masters.prereq_id}"
}

# Deployed private agent SSH user
output "private_agents.admin_username" {
  description = "Private Agents node SSH User"
  value       = "${module.private_agents.admin_username}"
}

# Returns the ID of the prereq script
output "private_agents.prereq_id" {
  description = "Returns the ID of the prereq script for private agents (if image are not used)"
  value       = "${module.private_agents.prereq_id}"
}

# Deployed public agent SSH user
output "public_agents.admin_username" {
  description = "Public Agents node SSH User"
  value       = "${module.public_agents.admin_username}"
}

# Returns the ID of the prereq script
output "public_agents.prereq_id" {
  description = "Returns the ID of the prereq script for public agents (if image are not used)"
  value       = "${module.public_agents.prereq_id}"
}

# Bootstrap private ip
output "bootstrap.private_ip" {
  description = "Private IP of the bootstrap instance"
  value       = "${module.bootstrap.private_ip}"
}

# Bootstrap public ip
output "bootstrap.public_ip" {
  description = "Public IP of the bootstrap instance"
  value       = "${module.bootstrap.public_ip}"
}

# masters public ip
output "masters.public_ips" {
  description = "Master instances public IPs"
  value       = "${module.masters.public_ips}"
}

# masters private ip
output "masters.private_ips" {
  description = "Master instances private IPs"
  value       = "${module.masters.private_ips}"
}

# private_agent public ip
output "private_agents.public_ips" {
  description = "Private Agent public IPs"
  value       = "${module.private_agents.public_ips}"
}

# private_agent private ip
output "private_agents.private_ips" {
  description = "Private Agent instances private IPs"
  value       = "${module.private_agents.private_ips}"
}

# public_agent public ip
output "public_agents.public_ips" {
  description = "Public Agent public IPs"
  value       = "${module.public_agents.public_ips}"
}

# public_agent private ip
output "public_agents.private_ips" {
  description = "Public Agent instances private IPs"
  value       = "${module.public_agents.private_ips}"
}

# LB Address
output "lb.masters" {
  description = "lb address"
  value       = "${module.loadbalancers.masters.lb_address}"
}

# LB Address
output "lb.masters-internal" {
  description = "lb address"
  value       = "${module.loadbalancers.masters-internal.lb_address}"
}

# LB Address
output "lb.public-agents" {
  description = "lb address"
  value       = "${module.loadbalancers.public-agents.lb_address}"
}

# Storage Key
output "azurerm_storage_key" {
  description = "Azure Storage Account Access Keys for External Exhibitor"
  value       = "${join(",", flatten(azurerm_storage_account.external_exhibitor.*.primary_access_key))}"
}
