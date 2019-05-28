variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

# Bootstrap node disk size (gb)
variable "bootstrap_disk_size" {
  description = "Bootstrap node disk size (gb)"
  default     = ""
}

# Bootstrap node disk type.
variable "bootstrap_disk_type" {
  description = "Bootstrap node disk type."
  default     = "Standard_LRS"
}

# Bootstrap node machine type
variable "bootstrap_vm_size" {
  description = "[BOOTSTRAP] Azure virtual machine size"
  default     = "Standard_B2s"
}

# Bootstrap node OS image
variable "bootstrap_image" {
  description = "[BOOTSTRAP] Image to be used"
  type        = "map"
  default     = {}
}

# Master node disk size (gb)
variable "masters_disk_size" {
  description = "Masters node disk size (gb)"
  default     = ""
}

# Master node disk type.
variable "masters_disk_type" {
  description = "Masters node disk type."
  default     = "Standard_LRS"
}

# Master node machine type
variable "masters_vm_size" {
  description = "[MASTERS] Azure virtual machine size"
  default     = "Standard_D4s_v3"
}

# Master node OS image
variable "masters_image" {
  description = "[MASTERS] Image to be used"
  type        = "map"
  default     = {}
}

# Private agent node disk size (gb)
variable "private_agents_disk_size" {
  description = "Private agent node disk size (gb)"
  default     = ""
}

# Private agent node disk type.
variable "private_agents_disk_type" {
  description = "Private agent node disk type."
  default     = "Standard_LRS"
}

# Private agent node machine type
variable "private_agents_vm_size" {
  description = "[PRIVATE AGENTS] Azure virtual machine size"
  default     = "Standard_D4s_v3"
}

# Private agent node OS image
variable "private_agents_image" {
  description = "[PRIVATE AGENTS] Image to be used"
  type        = "map"
  default     = {}
}

# Public agent disk size (gb)
variable "public_agents_disk_size" {
  description = "Public agent disk size (gb)"
  default     = ""
}

# Public agent node disk type.
variable "public_agents_disk_type" {
  description = "Public agent node disk type."
  default     = "Standard_LRS"
}

# Public agent machine type
variable "public_agents_vm_size" {
  description = "[PUBLIC AGENTS] Azure virtual machine size"
  default     = "Standard_D4s_v3"
}

# Public agent node OS image
variable "public_agents_image" {
  description = "[PUBLIC AGENTS] Image to be used"
  type        = "map"
  default     = {}
}

# Azure Region
variable "location" {
  description = "Azure Region"
  default     = ""
}

# Master node SSH User
variable "masters_admin_username" {
  description = "Master node SSH User"
  default     = ""
}

# Bootstrap node SSH User
variable "bootstrap_admin_username" {
  description = "Bootstrap node SSH User"
  default     = ""
}

# Public Agent node SSH User
variable "public_agents_admin_username" {
  description = "Public Agent node SSH User"
  default     = ""
}

# Private Agent ndoe SSH User
variable "private_agents_admin_username" {
  description = "Private Agent ndoe SSH User"
  default     = ""
}

# Global Infra SSH User
variable "infra_admin_username" {
  description = "Global Infra SSH User"
  default     = "dcos_admin"
}

variable "ssh_public_key" {
  description = "SSH public key in authorized keys format (e.g. 'ssh-rsa ..') to be used with the instances. Make sure you added this key to your ssh-agent."
  default     = ""
}

variable "ssh_public_key_file" {
  description = "Path to SSH public key. This is mandatory but can be set to an empty string if you want to use ssh_public_key with the key as string."
}

# Global Infra Disk Type
variable "infra_disk_type" {
  description = "Global Infra Disk Type"
  default     = "Standard_LRS"
}

# Global Infra Disk Size
variable "infra_disk_size" {
  description = "Global Infra Disk Size"
  default     = "128"
}

# Global Infra Machine Type
variable "infra_vm_size" {
  description = "Global Infra Machine Type"
  default     = "Standard_DS11_v2"
}

# Global Infra Tested OSes Image
variable "infra_dcos_instance_os" {
  description = "Global Infra Tested OSes Image"
  default     = "centos_7.3"
}

# Master node tested OSes image
variable "masters_dcos_instance_os" {
  description = "Master node tested OSes image"
  default     = ""
}

# Public Agent node tested OSes image
variable "public_agents_dcos_instance_os" {
  description = "Public Agent node tested OSes image"
  default     = ""
}

# Private agent node tested OSes image
variable "private_agents_dcos_instance_os" {
  description = "Private agent node tested OSes image"
  default     = ""
}

# Bootstrap node tested OSes image
variable "bootstrap_dcos_instance_os" {
  description = "Bootstrap node tested OSes image"
  default     = ""
}

##############################
#                            #
#  Terraform DCOS Variables  #
##############################

# Number of Masters
variable "num_masters" {
  description = "Specify the amount of masters. For redundancy you should have at least 3"
  default     = "3"
}

# Number of Private Agents
variable "num_private_agents" {
  description = "Specify the amount of private agents. These agents will provide your main resources"
  default     = "1"
}

# Number of Public Agents
variable "num_public_agents" {
  description = "Specify the amount of public agents. These agents will host marathon-lb and edgelb"
  default     = "1"
}

# DCOS Version
variable "dcos_version" {
  description = "Specifies which DC/OS version instruction to use. Options: 1.12.3, 1.11.10, etc. See dcos_download_path or dcos_version tree for a full list."
  default     = "1.11.4"
}

# Add special tags to the resources created by this module
variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "subnet_range" {
  description = "Private IP space to be used in CIDR format"
  default     = "172.31.0.0/16"
}

variable "admin_ips" {
  description = "List of CIDR admin IPs"
  type        = "list"
}

variable "public_agents_additional_ports" {
  description = "List of additional ports allowed for public access on public agents (80 and 443 open by default)"
  default     = []
}

variable "azurerm_storage_account_name" {
  description = "The Azure Storage Account Name for External Exhibitor"
  default     = ""
}
