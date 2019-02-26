#!/bin/bash

## Required tools:
## Install az cli   https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
## Install kubectl  https://kubernetes.io/docs/tasks/tools/install-kubectl/
## Install helm     https://helm.sh/
## note: you can also use the Azure Cloud Shell which includes these commands. https://azure.microsoft.com/en-us/features/cloud-shell/

RESOURCE_GROUP="php-poc"
AKS_CLUSTER_NAME="poccluster"
ACR_NAME="phppocregistry"
LOCATION="eastus2"

echo "Creating Resource Group: $RESOURCE_GROUP"
az group create -l $LOCATION -n $RESOURCE_GROUP

echo "Creating ASK Cluster: $AKS_CLUSTER_NAME"
az aks create -n $AKS_CLUSTER_NAME -g $RESOURCE_GROUP -l $LOCATION --generate-ssh-keys --enable-addons http_application_routing

echo "Creating Azure Container Registry: $ACR_NAME"
az acr create -n $ACR_NAME -g $RESOURCE_GROUP --sku Basic



echo "Setting up authentication between AKS and ACR"

# Get the id of the service principal configured for AKS
CLIENT_ID=$(az aks show --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)

# Get the ACR registry resource id
ACR_ID=$(az acr show --name $ACR_NAME --resource-group $RESOURCE_GROUP --query "id" --output tsv)

# Create role assignment
az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID

# Get Credentials for Kubectl
az aks get-credentials -n $AKS_CLUSTER_NAME -g $RESOURCE_GROUP 

# create service account for tiller
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller

# Install nginx ingress
helm install stable/nginx-ingress --namespace kube-system --set controller.replicaCount=2
