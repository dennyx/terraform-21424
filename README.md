# terraform-21424

sample repository for https://github.com/hashicorp/terraform/issues/21424

## setup

```bash
# specify terraform version to 0.12
git clone https://github.com/dennyx/terraform-21424.git
cd terraform-21424/terraform-main
terraform init
```

## sample output with terraform v0.12.0

```text
test@test:/opt/terraform-21424/terraform-main$ terraform -v
Terraform v0.12.0

test@test:/opt/terraform-21424/terraform-main$ terraform init
Initializing modules...
- dcos in ../terraform-azurerm-dcos
- dcos.dcos-infrastructure in ../terraform-azurerm-infrastructure
- dcos.dcos-infrastructure.bootstrap in ../terraform-azurerm-bootstrap
- dcos.dcos-infrastructure.bootstrap.dcos-bootstrap-instances in ../terraform-azurerm-instance
Downloading dcos-terraform/tested-oses/azurerm 0.1.3 for dcos.dcos-infrastructure.bootstrap.dcos-bootstrap-instances.dcos-tested-oses...
- dcos.dcos-infrastructure.bootstrap.dcos-bootstrap-instances.dcos-tested-oses in .terraform/modules/dcos.dcos-infrastructure.bootstrap.dcos-bootstrap-instances.dcos-tested-oses/dcos-terraform-terraform-azurerm-tested-oses-86d766d
Downloading dcos-terraform/vnet/azurerm 0.1.0 for dcos.dcos-infrastructure.network...
- dcos.dcos-infrastructure.network in .terraform/modules/dcos.dcos-infrastructure.network/dcos-terraform-terraform-azurerm-vnet-26cce30
Downloading dcos-terraform/nsg/azurerm 0.1.0 for dcos.dcos-infrastructure.network-security-group...
- dcos.dcos-infrastructure.network-security-group in .terraform/modules/dcos.dcos-infrastructure.network-security-group/dcos-terraform-terraform-azurerm-nsg-06b396a

Error: Invalid provider version constraint

Invalid version core constraint "" in dcos.dcos-infrastructure.bootstrap.


Error: Invalid provider version constraint

Invalid version core constraint "" in
dcos.dcos-infrastructure.network-security-group.
```

## output with terraform 0.11.13

```text
Initializing modules...
- module.dcos
  Getting source "../terraform-azurerm-dcos"
- module.dcos.dcos-infrastructure
  Getting source "../terraform-azurerm-infrastructure"
- module.dcos.dcos-infrastructure.network
  Found version 0.1.0 of dcos-terraform/vnet/azurerm on registry.terraform.io
  Getting source "dcos-terraform/vnet/azurerm"
- module.dcos.dcos-infrastructure.network-security-group
  Found version 0.1.0 of dcos-terraform/nsg/azurerm on registry.terraform.io
  Getting source "dcos-terraform/nsg/azurerm"
- module.dcos.dcos-infrastructure.bootstrap
  Getting source "../terraform-azurerm-bootstrap"
- module.dcos.dcos-infrastructure.bootstrap.dcos-bootstrap-instances
  Getting source "../terraform-azurerm-instance"
- module.dcos.dcos-infrastructure.bootstrap.dcos-bootstrap-instances.dcos-tested-oses
  Found version 0.1.3 of dcos-terraform/tested-oses/azurerm on registry.terraform.io
  Getting source "dcos-terraform/tested-oses/azurerm"

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "azurerm" (1.29.0)...
- Downloading plugin for provider "http" (1.1.1)...
- Downloading plugin for provider "null" (2.1.2)...
- Downloading plugin for provider "random" (2.1.2)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.azurerm: version = "~> 1.29"
* provider.http: version = "~> 1.1"
* provider.null: version = "~> 2.1"
* provider.random: version = "~> 2.1"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
