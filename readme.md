### Php POC

## Project Summary
This is a sample project that builds a CI/CD pipeline using [Azure DevOps](dev.azure.com) and targeting [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/)

This project uses an nginx ingress controller to route traffic to multiple versions of an application.

In the build pipeline you can specify an envName which will be used as the name of the helm chart and the path in the url .

eg- envName = foo will be routed via /foo

### Requirements
* [az cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [helm](https://helm.sh/)

### Creating the infrastructure
Please execute the [create.sh](infrastructure/create.sh) script located in the infrastructure folder.

As part of the creation project the following Azure resources will be created:
* A new resource group called php-poc
* A 3 node AKS Cluster
* An ACR (Azure Container Registry) named phppocregistry

Post resource creation the following configuration steps takes place in create.sh
* Authentication between the AKS cluster and ACR is set up.
* Local kubectl configuration for new AKS cluster is set up.
* A new kubernetes service account is created for tiller (used by helm), and helm is initialized.
* The [nginx-ingress](https://github.com/kubernetes/ingress-nginx) helm chart is installed on the cluster.

## Azure DevOps Setup
Both the Azure DevOps [build pipline](infrastructure/azure-pipelines.build.yml) and [release pipline](infrastructure/azure-pipelines.release.yml)steps were exported to yaml and include in the infrastructure folder.

## Get external IP of nginx-ingress
```kubectl get svc --all-namespaces  | grep LoadBalancer | grep -v 'addon-http-application-routing-nginx-ingress'```

## kubectl,helm,az useful commands

* Verify cluster is running and you are connected: ```kubectl get pods --all namespaces```
* See running pods after a deploment ```kubectl get pods```
* See services ```kubectl get svc```
* See ingresses ```kubectl get ingresses```
* describe a pod ```kubectr describe pod <pod_name>``` (pod name can be found via get pods)
* helm list ```helm ls```
* helm delete ``` helm del --purge <name>``` (name can be found in helm list)
* az acr show tags for an image ```az acr repository show-tags -n <acr_name> --repository <image>```
* configure local kubectl via az ```az aks get-credentials --resource-group php-poc --name poccluster``` (note create.sh runs this for you)


### Tear down
To clear out all infrastructure for this project, please execute the [cleanup.sh](infrastructure/cleanup.sh) script located in the infrastructure folder.

### Resources

* [Azure DevOps](dev.azure.com) 
* [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/)
* [Authenticate with Azure Container Registry from Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-aks)
* [Azure Container Registry authentication with service principals](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-service-principal)
* [Use an Azure managed identity to authenticate to an Azure container registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-authentication-managed-identity)

