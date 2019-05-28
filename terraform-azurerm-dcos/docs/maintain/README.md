# Maintain DC/OS on Azure

If you would like to add more or remove (private) agents or public agents from your cluster, you can do so by telling terraform your desired state and it will make sure it gets you there.

## Adding Agents

```bash
# update num_private_agents = "5" in main.tf
terraform apply
```

## Removing Agents

```bash
# update num_private_agents = "2" in main.tf
terraform apply
```

## Documentation

1. [Deploying on Azure](./install/README.md)
2. [Upgrading DC/OS](./upgrade/README.md)
3. Maintaining Nodes
4. [Destroy](./destroy/README.md)
