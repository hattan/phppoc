### Php POC

## Project Summary
This is a sample project that builds a CI/CD pipeline using [Azure DevOps](dev.azure.com) and targeting [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/)

### Requirements
* [az cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [helm](https://helm.sh/)

### Creating the infrastructure
Please execute the [create.sh](infrastructure/create.sh) script located in the infrastructure folder.


### Tear down
To clear out all infrastructure for this project, please execute the [cleanup.sh](infrastructure/cleanup.sh) script located in the infrastructure folder.

### Resources

* [Azure DevOps](dev.azure.com) 
* [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/)
* [Authenticate with Azure Container Registry from Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-aks)
* [Azure Container Registry authentication with service principals](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-service-principal)
* [Use an Azure managed identity to authenticate to an Azure container registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-authentication-managed-identity)

