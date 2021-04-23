# GitHub Actions POC testing using Terraform code to deploy infrastructure to Azure


1. Create a resource group and storage account for Terraform remote state

````
SUBSCRIPTION_ID=$(az account show --query id --output tsv)
RESOURCE_GROUP_NAME="github-actions-terraform-poc-rg"
STORAGE_ACCOUNT_NAME="mabegithubtfstatestore"
STORAGE_ACCOUNT_CONTAINER="terraform-state"

az group create -g $RESOURCE_GROUP_NAME -l eastus

az storage account create -n $STORAGE_ACCOUNT_NAME -g $RESOURCE_GROUP_NAME -l eastus --sku Standard_LRS

az storage container create -n $STORAGE_ACCOUNT_CONTAINER --account-name $STORAGE_ACCOUNT_NAME

az ad sp create-for-rbac --name "github-actions-terraform-poc-spn" --role Contributor --scopes /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP_NAME --sdk-auth
````
