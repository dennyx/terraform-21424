# DC/OS Enterprise simple cluster
In this example we spawn a simple cluster with just one master, two agents and one public agent.

# [`main.tf`](./main.tf?raw=1)
Just do an copy of [`main.tf`](./main.tf?raw=1) in a local folder and `cd` into it.

# `cluster.tfvars`
For this cluster we need to set your ssh public key..

if you already have a ssh key. Just read the public key content and assign it to the terraform variable. Also you should set a cluster name. It gets tagged with this name so you can easily identify the nodes of your cluster.

```bash
# or similar depending on your environment
echo "public_ssh_key_path=\"~/.ssh/id_rsa.pub\"" >> cluster.tfvars
# lets set the clustername
echo "name_prefix=\"my-ee-cluster\"" >> cluster.tfvars
# we at mesosphere have to tag our instances with an owner and an expire date.
echo "tags={owner = \"$(whoami)\", expiration = \"2h\"}" >> cluster.tfvars
# we have to explicitly set the version.
echo "dcos_version=\"1.10.8\"" >> cluster.tfvars
# paste your license key here
echo "dcos_license_key_contents=\"abcdef123456\"" >> cluster.tfvars
# we can set the azure location
echo "location=\"West US\"" >> cluster.tfvars
```

## admin_ips (optional)
For accessing your dcos-masters we only allow access for certain IPs. By adding a lists `admin_ips` you could control this. *If you do now specify `admin_ips` we try to detect your current public IP and use this address. These addresses have to be written in CIDR format. So for single addresses use `1.2.3.4/32`

### allow your company net

```bash
echo "admin_ips=[\"1.2.3.0/24\", \"3.2.1.0/24\"]" >> cluster.tfvars
```

### allow all (be sure what you're doing)
```bash
echo "admin_ips=[\"0.0.0.0/0\"]" >> cluster.tfvars
```

# Azure
DC/OS Terraform can use the credentials passes via `az login`. You can [Download](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) the azure 2.0 cli with the link provided.

# terraform init
Doing terraform init lets terraform download all the needed modules to spawn DC/OS Cluster on AWS

```bash
$ terraform init
```

<!---
A terraform bug was noticed when using the terraform apply <plan> method. The tradition terraform apply method works for the time being. We will investigate why this error produces this bug below:

                                                                                                                                                                                                                                                           
```
$ terraform apply "cluster.plan"
Error: Error applying plan:

1 error(s) occurred:

* module.dcos.provider.aws: Not a valid region: 

Terraform does not automatically rollback in the face of errors.
Instead, your Terraform state file has been partially updated with
any resources that successfully completed. Please address the error
above and apply again to incrementally change your infrastructure
```

---REMOVED

# terraform plan
We expect your aws environment is properly setup. Check it with issuing `aws sts get-caller-identity`.

We now create the terraform plan which gets applied later on.
```bash
$ terraform plan -var-file cluster.tfvars -out=cluster.plan
```

# terraform apply
Now we're applying our plan

```bash
$ terraform apply "cluster.plan"
```

in the output section you will find the hostname of your cluster. With this hostname you'll be able to access the cluster.
---REMOVED

REPO'D ON VERSION:
```
$ terraform -v
Terraform v0.11.8
```

+Replaced with section below
-->

# terraform apply
Now we're applying our plan

```bash
$ terraform plan -var-file cluster.tfvars 
```

in the output section you will find the hostname of your cluster. With this hostname you'll be able to access the cluster.

# terraform destroy
If you want to destroy your cluster again use

```bash
$ terraform destroy -var-file cluster.tfvars
```
