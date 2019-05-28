/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-infrastructure/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-infrastructure/job/master/)
 * # DC/OS Azure Infrastucture
 *
 * This module creates typical DS/OS infrastructure in Azure.
 *
 * ## EXAMPLE
 *
 * ```hcl
 * module "dcos-infrastructure" {
 *   source  = "terraform-dcos/infrastructure/azurerm"
 *   version = "~> 0.1.0"
 *
 *   infra_public_ssh_key_path = "~/.ssh/id_rsa.pub"
 *
 *   num_masters = "3"
 *   num_private_agents = "2"
 *   num_public_agents = "1"
 * }
 * ```
 */

# data "null_data_source" "lb_rules" {
#   count = "${length(var.public_agents_additional_ports)}"

#   inputs = {
#     frontend_port = "${element(var.public_agents_additional_ports, count.index)}"
#   }
# }

provider "azurerm" {}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "dcos-${var.cluster_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

module "network" {
  source  = "dcos-terraform/vnet/azurerm"
  version = "~> 0.1.0"

  providers = {
    azurerm = "azurerm"
  }

  subnet_range = "${var.subnet_range}"
  cluster_name = "${var.cluster_name}"
  location     = "${var.location}"

  resource_group_name = "${azurerm_resource_group.rg.name}"
  tags                = "${var.tags}"
}

module "network-security-group" {
  source  = "dcos-terraform/nsg/azurerm"
  version = "~> 0.1.0"

  providers = {
    azurerm = "azurerm"
    
  }

  location                       = "${var.location}"
  subnet_range                   = "${var.subnet_range}"
  cluster_name                   = "${var.cluster_name}"
  admin_ips                      = ["${var.admin_ips}"]
  public_agents_additional_ports = ["${var.public_agents_additional_ports}"]

  resource_group_name = "${azurerm_resource_group.rg.name}"
  tags                = "${var.tags}"
}

# // If External Exhibitor is Specified, Create a Storage Account
# resource "azurerm_storage_account" "external_exhibitor" {
#   count                    = "${var.azurerm_storage_account_name != "" ? 1 : 0}"
#   name                     = "${var.azurerm_storage_account_name}"
#   resource_group_name      = "${azurerm_resource_group.rg.name}"
#   location                 = "${var.location}"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   tags                     = "${var.tags}"
# }

# module "loadbalancers" {
#   source  = "dcos-terraform/lb-dcos/azurerm"
#   version = "~> 0.1.0"

#   providers = {
#     azurerm = "azurerm"
#   }

#   location                       = "${var.location}"
#   cluster_name                   = "${var.cluster_name}"
#   subnet_id                      = "${module.network.subnet_id}"
#   public_agents_additional_rules = ["${data.null_data_source.lb_rules.*.outputs}"]

#   resource_group_name = "${azurerm_resource_group.rg.name}"
#   tags                = "${var.tags}"
# }

module "bootstrap" {
  source  = "../terraform-azurerm-bootstrap"

  providers = {
    azurerm = "azurerm"
    
  }

  location                  = "${var.location}"
  disk_size                 = "${coalesce(var.bootstrap_disk_size, var.infra_disk_size)}"
  disk_type                 = "${coalesce(var.bootstrap_disk_type, var.infra_disk_type)}"
  vm_size                   = "${coalesce(var.bootstrap_vm_size, var.infra_vm_size)}"
  name_prefix               = "${var.cluster_name}"
  ssh_public_key            = "${file(var.ssh_public_key_file)}"
  admin_username            = "${coalesce(var.bootstrap_admin_username, var.infra_admin_username)}"
  image                     = "${var.bootstrap_image}"
  dcos_instance_os          = "${coalesce(var.bootstrap_dcos_instance_os, var.infra_dcos_instance_os)}"
  resource_group_name       = "${azurerm_resource_group.rg.name}"
  subnet_id                 = "${module.network.subnet_id}"
  network_security_group_id = "${module.network-security-group.bootstrap.nsg_id}"

  # Determine if we need to force a particular location
  dcos_version = "${var.dcos_version}"
  tags         = "${var.tags}"
}
