# terraform-21424

sample repository for https://github.com/hashicorp/terraform/issues/21424

## setup

```bash
# specify terraform version to 0.12
git clone https://github.com/dennyx/terraform-21424.git
cd terraform-main
terraform init
```

## sample output 

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

Error: Invalid provider version constraint

Invalid version core constraint "" in dcos.dcos-infrastructure.bootstrap.
```
