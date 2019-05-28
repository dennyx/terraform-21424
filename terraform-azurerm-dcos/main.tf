/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-dcos/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-dcos/job/master/)
 * # terraform azurerm dcos
 *
 * Convenience wrapper for Azure
 *
 * ## Deploy DC/OS on Azure using Terraform
 *
 * [Starting Guide](https://github.com/dcos-terraform/terraform-azurerm-dcos/blob/master/docs/published/README.md)
 *
 * Get started with using this module by reading the documentation here: [README.md](https://github.com/dcos-terraform/terraform-azurerm-dcos/tree/master/docs/README.md)
 *
 * ## Usage
 *
 *```hcl
 * module "dcos" {
 *   source  = "dcos-terraform/dcos/azurerm"
 *   version = "~> 0.1.0"
 *
 *   cluster_name = "mydcoscluster"
 *   infra_public_ssh_key_path = "~/.ssh/key.pub"
 *   admin_ips = ['198.51.100.0/24']
 *
 *   num_masters = "3"
 *   num_private_agentss = "2"
 *   num_public_agentss = "1"
 *
 *   dcos_cluster_docker_credentials_enabled =  "true"
 *   dcos_cluster_docker_credentials_write_to_etc = "true"
 *   dcos_cluster_docker_credentials_dcos_owned = "false"
 *   dcos_cluster_docker_registry_url = "https://index.docker.io"
 *   dcos_use_proxy = "yes"
 *   dcos_http_proxy = "example.com"
 *   dcos_https_proxy = "example.com"
 *   dcos_no_proxy = <<EOF
 *   # YAML
 *    - "internal.net"
 *    - "169.254.169.254"
 *   EOF
 *   dcos_overlay_network = <<EOF
 *   # YAML
 *       vtep_subnet: 44.128.0.0/20
 *       vtep_mac_oui: 70:B3:D5:00:00:00
 *       overlays:
 *         - name: dcos
 *           subnet: 12.0.0.0/8
 *           prefix: 26
 *   EOF
 *   dcos_rexray_config = <<EOF
 *   # YAML
 *     rexray:
 *       loglevel: warn
 *       modules:
 *         default-admin:
 *           host: tcp://127.0.0.1:61003
 *       storageDrivers:
 *       - ec2
 *       volume:
 *         unmount:
 *           ignoreusedcount: true
 *   EOF
 *   dcos_cluster_docker_credentials = <<EOF
 *   # YAML
 *     auths:
 *       'https://index.docker.io/v1/':
 *         auth: Ze9ja2VyY3licmljSmVFOEJrcTY2eTV1WHhnSkVuVndjVEE=
 *   EOF
 *
 *   # dcos_variant              = "ee"
 *   # dcos_license_key_contents = "${file("./license.txt")}"
 *   dcos_variant = "open"
 * }
 *```
 */

provider "azurerm" {}

resource "random_id" "id" {
  byte_length = 2
  prefix      = "${var.cluster_name}"
}

locals {
  cluster_name = "${var.cluster_name_random_string ? random_id.id.hex : var.cluster_name}"
}

module "dcos-infrastructure" {
  source  = "../terraform-azurerm-infrastructure"

  cluster_name           = "${local.cluster_name}"
  infra_dcos_instance_os = "${var.dcos_instance_os}"
  ssh_public_key_file    = "${var.ssh_public_key_file}"

  bootstrap_image            = "${var.bootstrap_image}"
  bootstrap_vm_size          = "${var.bootstrap_vm_size}"
  bootstrap_dcos_instance_os = "${var.bootstrap_os}"
  bootstrap_disk_size        = "${var.bootstrap_root_volume_size}"
  bootstrap_disk_type        = "${var.bootstrap_root_volume_type}"

  num_masters        = "${var.num_masters}"
  num_private_agents = "${var.num_private_agents}"
  num_public_agents  = "${var.num_public_agents}"
  admin_ips          = "${var.admin_ips}"
  subnet_range       = "${var.subnet_range}"

  location     = "${var.location}"
  tags         = "${var.tags}"
  dcos_version = "${var.dcos_version}"

  # If defining external exhibitor storage
  azurerm_storage_account_name = "${var.dcos_exhibitor_azure_account_name}"

  providers = {
    azurerm = "azurerm"
  }
}
