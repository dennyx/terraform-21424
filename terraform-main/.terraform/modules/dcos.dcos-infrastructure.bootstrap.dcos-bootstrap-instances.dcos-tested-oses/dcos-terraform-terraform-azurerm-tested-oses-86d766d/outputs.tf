# Output
output "user" {
  description = "User"
  value       = "${local.user}"
}

output "azure_offer" {
  description = "Azure Offer"
  value       = "${local.azure_offer}"
}

output "azure_publisher" {
  description = "Azure Publisher"
  value       = "${local.azure_publisher}"
}

output "azure_sku" {
  description = "Azure SKU"
  value       = "${local.azure_sku}"
}

output "azure_version" {
  description = "Azure Version"
  value       = "${local.azure_version}"
}

# Main Output
output "os-setup" {
  description = "os-setup"
  value       = "${local.script}"
}
