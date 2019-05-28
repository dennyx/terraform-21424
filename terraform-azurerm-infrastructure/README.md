[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-infrastructure/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-infrastructure/job/master/)
# DC/OS Azure Infrastucture

This module creates typical DS/OS infrastructure in Azure.

## EXAMPLE

```hcl
module "dcos-infrastructure" {
  source  = "terraform-dcos/infrastructure/azurerm"
  version = "~> 0.1.0"

  infra_public_ssh_key_path = "~/.ssh/id_rsa.pub"

  num_masters = "3"
  num_private_agents = "2"
  num_public_agents = "1"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin\_ips | List of CIDR admin IPs | list | n/a | yes |
| cluster\_name | Name of the DC/OS cluster | string | n/a | yes |
| ssh\_public\_key\_file | Path to SSH public key. This is mandatory but can be set to an empty string if you want to use ssh_public_key with the key as string. | string | n/a | yes |
| azurerm\_storage\_account\_name | The Azure Storage Account Name for External Exhibitor | string | `""` | no |
| bootstrap\_admin\_username | Bootstrap node SSH User | string | `""` | no |
| bootstrap\_dcos\_instance\_os | Bootstrap node tested OSes image | string | `""` | no |
| bootstrap\_disk\_size | Bootstrap node disk size (gb) | string | `""` | no |
| bootstrap\_disk\_type | Bootstrap node disk type. | string | `"Standard_LRS"` | no |
| bootstrap\_image | [BOOTSTRAP] Image to be used | map | `<map>` | no |
| bootstrap\_vm\_size | [BOOTSTRAP] Azure virtual machine size | string | `"Standard_B2s"` | no |
| dcos\_version | Specifies which DC/OS version instruction to use. Options: 1.12.3, 1.11.10, etc. See dcos_download_path or dcos_version tree for a full list. | string | `"1.11.4"` | no |
| infra\_admin\_username | Global Infra SSH User | string | `"dcos_admin"` | no |
| infra\_dcos\_instance\_os | Global Infra Tested OSes Image | string | `"centos_7.3"` | no |
| infra\_disk\_size | Global Infra Disk Size | string | `"128"` | no |
| infra\_disk\_type | Global Infra Disk Type | string | `"Standard_LRS"` | no |
| infra\_vm\_size | Global Infra Machine Type | string | `"Standard_DS11_v2"` | no |
| location | Azure Region | string | `""` | no |
| masters\_admin\_username | Master node SSH User | string | `""` | no |
| masters\_dcos\_instance\_os | Master node tested OSes image | string | `""` | no |
| masters\_disk\_size | Masters node disk size (gb) | string | `""` | no |
| masters\_disk\_type | Masters node disk type. | string | `"Standard_LRS"` | no |
| masters\_image | [MASTERS] Image to be used | map | `<map>` | no |
| masters\_vm\_size | [MASTERS] Azure virtual machine size | string | `"Standard_D4s_v3"` | no |
| num\_masters | Specify the amount of masters. For redundancy you should have at least 3 | string | `"3"` | no |
| num\_private\_agents | Specify the amount of private agents. These agents will provide your main resources | string | `"1"` | no |
| num\_public\_agents | Specify the amount of public agents. These agents will host marathon-lb and edgelb | string | `"1"` | no |
| private\_agents\_admin\_username | Private Agent ndoe SSH User | string | `""` | no |
| private\_agents\_dcos\_instance\_os | Private agent node tested OSes image | string | `""` | no |
| private\_agents\_disk\_size | Private agent node disk size (gb) | string | `""` | no |
| private\_agents\_disk\_type | Private agent node disk type. | string | `"Standard_LRS"` | no |
| private\_agents\_image | [PRIVATE AGENTS] Image to be used | map | `<map>` | no |
| private\_agents\_vm\_size | [PRIVATE AGENTS] Azure virtual machine size | string | `"Standard_D4s_v3"` | no |
| public\_agents\_additional\_ports | List of additional ports allowed for public access on public agents (80 and 443 open by default) | list | `<list>` | no |
| public\_agents\_admin\_username | Public Agent node SSH User | string | `""` | no |
| public\_agents\_dcos\_instance\_os | Public Agent node tested OSes image | string | `""` | no |
| public\_agents\_disk\_size | Public agent disk size (gb) | string | `""` | no |
| public\_agents\_disk\_type | Public agent node disk type. | string | `"Standard_LRS"` | no |
| public\_agents\_image | [PUBLIC AGENTS] Image to be used | map | `<map>` | no |
| public\_agents\_vm\_size | [PUBLIC AGENTS] Azure virtual machine size | string | `"Standard_D4s_v3"` | no |
| ssh\_public\_key | SSH public key in authorized keys format (e.g. 'ssh-rsa ..') to be used with the instances. Make sure you added this key to your ssh-agent. | string | `""` | no |
| subnet\_range | Private IP space to be used in CIDR format | string | `"172.31.0.0/16"` | no |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| azurerm\_storage\_key | Azure Storage Account Access Keys for External Exhibitor |
| bootstrap.admin\_username | Bootstrap node SSH User |
| bootstrap.prereq\_id | Returns the ID of the prereq script (if image are not used) |
| bootstrap.private\_ip | Private IP of the bootstrap instance |
| bootstrap.public\_ip | Public IP of the bootstrap instance |
| lb.masters | lb address |
| lb.masters-internal | lb address |
| lb.public-agents | lb address |
| masters.admin\_username | Masters node SSH User |
| masters.prereq\_id | Returns the ID of the prereq script for masters (if user_data or ami are not used) |
| masters.private\_ips | Master instances private IPs |
| masters.public\_ips | Master instances public IPs |
| private\_agents.admin\_username | Private Agents node SSH User |
| private\_agents.prereq\_id | Returns the ID of the prereq script for private agents (if image are not used) |
| private\_agents.private\_ips | Private Agent instances private IPs |
| private\_agents.public\_ips | Private Agent public IPs |
| public\_agents.admin\_username | Public Agents node SSH User |
| public\_agents.prereq\_id | Returns the ID of the prereq script for public agents (if image are not used) |
| public\_agents.private\_ips | Public Agent instances private IPs |
| public\_agents.public\_ips | Public Agent public IPs |

