/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-instance/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-instance/job/master/)
 *
 * The module creates AzureRM virtual machine instances
 *
 * ## EXAMPLE
 *
 * ```hcl
 * module "dcos-master-instances" {
 *   source  = "dcos-terraform/instance/azurerm"
 *   version = "~> 0.1.0"
 *
 *   num_instances                = "${var.num_masters}"
 *   location                     = "${var.location}"
 *   dcos_version                 = "${var.dcos_version}"
 *   dcos_instance_os             = "${var.dcos_instance_os}"
 *   ssh_private_key_filename     = "${var.ssh_private_key_filename}"
 *   image                        = "${var.image}"
 *   resource_group_name          = "${var.resource_group_name}"
 *   ...
 * }
 * ```
 */

provider "azurerm" {}

locals {
  private_key = "${file(var.ssh_private_key_filename)}"
  agent       = "${var.ssh_private_key_filename == "/dev/null" ? true : false}"
}

module "dcos-tested-oses" {
  source  = "dcos-terraform/tested-oses/azurerm"
  version = "~> 0.1.0"

  providers = {
    azurerm = "azurerm"
  }

  os           = "${var.dcos_instance_os}"
  dcos_version = "${var.dcos_version}"
}

locals {
  image_publisher = "${length(var.image) > 0 ? lookup(var.image, "publisher", "") : module.dcos-tested-oses.azure_publisher }"
  image_sku       = "${length(var.image) > 0 ? lookup(var.image, "sku", "") : module.dcos-tested-oses.azure_sku }"
  image_version   = "${length(var.image) > 0 ? lookup(var.image, "version", "") : module.dcos-tested-oses.azure_version }"
  image_offer     = "${length(var.image) > 0 ? lookup(var.image, "offer", "") : module.dcos-tested-oses.azure_offer }"
}

# instance Node
resource "azurerm_managed_disk" "instance_managed_disk" {
  count                = "${var.num}"
  name                 = "${format(var.hostname_format, count.index + 1, var.name_prefix)}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "${var.disk_size}"
}

# Public IP addresses for the Public Front End load Balancer
resource "azurerm_public_ip" "instance_public_ip" {
  count                        = "${var.num}"
  name                         = "${format(var.hostname_format, count.index + 1, var.name_prefix)}-pub-ip"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  public_ip_address_allocation = "dynamic"
  domain_name_label            = "${format(var.hostname_format, count.index + 1, var.name_prefix)}"

  tags = "${merge(var.tags, map("Name", format(var.hostname_format, (count.index + 1), var.location, var.name_prefix),
                                "Cluster", var.name_prefix))}"
}

# Create an availability set
resource "azurerm_availability_set" "instance_av_set" {
  name                         = "${format(var.hostname_format, count.index + 1, var.name_prefix)}-avset"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  platform_fault_domain_count  = 3
  platform_update_domain_count = 1
  managed                      = true
}

# Instance NICs
resource "azurerm_network_interface" "instance_nic" {
  name                      = "${format(var.hostname_format, count.index + 1, var.name_prefix)}-nic"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group_name}"
  network_security_group_id = "${var.network_security_group_id}"
  count                     = "${var.num}"

  ip_configuration {
    name                                    = "${format(var.hostname_format, count.index + 1, var.name_prefix)}-ipConfig"
    subnet_id                               = "${var.subnet_id}"
    private_ip_address_allocation           = "dynamic"
    public_ip_address_id                    = "${element(azurerm_public_ip.instance_public_ip.*.id, count.index)}"
    load_balancer_backend_address_pools_ids = ["${compact(concat(var.public_backend_address_pool, var.private_backend_address_pool))}"]
  }

  tags = "${merge(var.tags, map("Name", format(var.hostname_format, (count.index + 1), var.location, var.name_prefix),
                                "Cluster", var.name_prefix))}"
}

# Master VM Coniguration
resource "azurerm_virtual_machine" "instance" {
  name                             = "${format(var.hostname_format, count.index + 1, var.name_prefix)}"
  location                         = "${var.location}"
  resource_group_name              = "${var.resource_group_name}"
  network_interface_ids            = ["${element(azurerm_network_interface.instance_nic.*.id, count.index)}"]
  availability_set_id              = "${azurerm_availability_set.instance_av_set.id}"
  vm_size                          = "${var.vm_size}"
  count                            = "${var.num}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "${contains(keys(var.image), "id") ? "" : module.dcos-tested-oses.azure_publisher}"
    offer     = "${contains(keys(var.image), "id") ? "" : module.dcos-tested-oses.azure_offer}"
    sku       = "${contains(keys(var.image), "id") ? "" : module.dcos-tested-oses.azure_sku}"
    version   = "${contains(keys(var.image), "id") ? "" : module.dcos-tested-oses.azure_version}"
    id        = "${lookup(var.image, "id", "")}"
  }

  storage_os_disk {
    name              = "os-disk-${format(var.hostname_format, count.index + 1, var.name_prefix)}"
    caching           = "ReadOnly"
    create_option     = "FromImage"
    managed_disk_type = "${var.disk_type}"
  }

  storage_data_disk {
    name            = "${azurerm_managed_disk.instance_managed_disk.*.name[count.index]}"
    managed_disk_id = "${azurerm_managed_disk.instance_managed_disk.*.id[count.index]}"
    create_option   = "Attach"
    caching         = "None"
    lun             = 0
    disk_size_gb    = "${azurerm_managed_disk.instance_managed_disk.*.disk_size_gb[count.index]}"
  }

  os_profile {
    computer_name  = "${format(var.hostname_format, count.index + 1, var.name_prefix)}"
    admin_username = "${coalesce(var.admin_username, module.dcos-tested-oses.user)}"
    custom_data    = "${var.custom_data}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${coalesce(var.admin_username, module.dcos-tested-oses.user)}/.ssh/authorized_keys"
      key_data = "${var.ssh_public_key}"
    }
  }

  tags = "${merge(var.tags, map("Name", format(var.hostname_format, (count.index + 1), var.location, var.name_prefix),
                                "Cluster", var.name_prefix))}"
}

resource "null_resource" "instance-prereq" {
  # If the user supplies an AMI or custom_data we expect the prerequisites are met.
  count = "${var.num}"
  count = "${(length(var.image) == 0 && var.custom_data == "") ? var.num : 0}"

  connection {
    host        = "${element(azurerm_public_ip.instance_public_ip.*.fqdn, count.index)}"
    user        = "${coalesce(var.admin_username, module.dcos-tested-oses.user)}"
    private_key = "${local.private_key}"
    agent       = "${local.agent}"
  }

  provisioner "file" {
    content     = "${module.dcos-tested-oses.os-setup}"
    destination = "/tmp/dcos-prereqs.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/dcos-prereqs.sh",
      "sudo bash -x /tmp/dcos-prereqs.sh",
    ]
  }

  depends_on = ["azurerm_virtual_machine.instance"]
}
