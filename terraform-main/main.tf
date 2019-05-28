variable "dcos_install_mode" {
  description = "specifies which type of command to execute. Options: install or upgrade"
  default = "install"
}

data "http" "whatismyip" {
  url = "http://whatismyip.akamai.com/"
}

provider "azurerm" {
  
}

module "dcos" {
  source  = "../terraform-azurerm-dcos"

  dcos_instance_os    = "centos_7.5"
  cluster_name        = "dcos-dev"
  ssh_public_key_file = "dcos_key.pub"
  admin_ips           = ["${data.http.whatismyip.body}/32"]
  location            = "West US"

  # node numbers
  num_masters          = "1"
  num_private_agents   = "1"
  num_public_agents    = "1"

  dcos_version = "1.12.0"

  # dcos_variant              = "ee"
  # dcos_license_key_contents = "${file("./license.txt")}"
  dcos_variant = "open"
  dcos_oauth_enabled = "false"

  providers = {
    azurerm = "azurerm"
  }

  dcos_install_mode = "${var.dcos_install_mode}"
}

