# Number of Instance
variable "num" {
  description = "How many instances should be created"
}

# Location (region)
variable "location" {
  description = "Azure Region"
}

# Cluster Name
variable "name_prefix" {
  description = "Name Prefix"
}

# Instance Type
variable "vm_size" {
  description = "Azure virtual machine size"
}

# DCOS Version for prereq install
variable "dcos_version" {
  description = "Specifies which DC/OS version instruction to use. Options: 1.12.3, 1.11.10, etc. See dcos_download_path or dcos_version tree for a full list."
}

# Tested OSes to install with prereq
variable "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
}

# Private SSH Key Filename Optional
variable "ssh_private_key_filename" {
  description = "Path to the SSH private key"

  # cannot leave this empty as the file() interpolation will fail later on for the private_key local variable
  # https://github.com/hashicorp/terraform/issues/15605
  default = "/dev/null"
}

# Source image to boot from. We assume the user has already take care of the prereq during this step.
variable "image" {
  description = "Source image to boot from"
  type        = "map"
  default     = {}
}

# Disk Type to Leverage. The managed disk type. (optional)
variable "disk_type" {
  description = "Disk Type to Leverage"
  default     = "Standard_LRS"
}

# Disk Size in GB
variable "disk_size" {
  description = "Disk Size in GB"
}

# Resource Group Name
variable "resource_group_name" {
  description = "Name of the azure resource group"
}

# Customer Provided Userdata
variable "custom_data" {
  description = "User data to be used on these instances (cloud-init)"
  default     = ""
}

# SSH User
variable "admin_username" {
  description = "SSH User"
}

# SSH Public Key
variable "ssh_public_key" {
  description = "SSH public key in authorized keys format (e.g. 'ssh-rsa ..') to be used with the instances. Make sure you added this key to your ssh-agent."
  default     = ""
}

# Add special tags to the resources created by this module
variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

# Format the hostname inputs are index+1, region, name_prefix
variable "hostname_format" {
  description = "Format the hostname inputs are index+1, region, cluster_name"
  default     = "instance-%[1]d-%[2]s"
}

# Public backend address pool
variable "public_backend_address_pool" {
  description = "Public backend address pool"
  type        = "list"
  default     = []
}

# Private backend address pool
variable "private_backend_address_pool" {
  description = "Private backend address pool"
  type        = "list"
  default     = []
}

# Security Group Id
variable "network_security_group_id" {
  description = "Security Group Id"
  default     = ""
}

# Subnet ID
variable "subnet_id" {
  description = "Subnet ID"
}
