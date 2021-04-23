# GitHub Actions POC with Terraform for Azure

This is a POC to demo using GitHub Actions with Terraform code to deploy Infrasacuture to Azure

### Prerequisites

1. Create a resource group, storage account, and container for the Terraform remote state:

````
SUBSCRIPTION_ID=$(az account show --query id --output tsv)
RESOURCE_GROUP_NAME="github-actions-terraform-poc-rg"
RESOURCE_GROUP_LOCATION="eastus"
STORAGE_ACCOUNT_NAME="<PROVIDE A GLOBALLY UNIQUE STORAGE ACCOUNT NAME>"
STORAGE_ACCOUNT_CONTAINER="terraform-state"

az group create -g $RESOURCE_GROUP_NAME -l $RESOURCE_GROUP_LOCATION

az storage account create -n $STORAGE_ACCOUNT_NAME -g $RESOURCE_GROUP_NAME -l $RESOURCE_GROUP_LOCATION --sku Standard_LRS

az storage container create -n $STORAGE_ACCOUNT_CONTAINER --account-name $STORAGE_ACCOUNT_NAME
````

2. Create an Azure service principal with access to your subscription using the command below. Save the generated Client ID and Client Secret in your repository Secrets:

````
az ad sp create-for-rbac --name "github-actions-terraform-poc-spn" --role Contributor --scopes /subscriptions/$SUBSCRIPTION_ID/ --sdk-auth
`````

3. Edit the GitHub Actions workflows as needed, [terraform-plan.yml](.github/workflows/terraform-plan.yml) and [terraform-apply.yml](.github/workflows/terraform-apply.yml)


### Testing
1. Create a pull request, when the pull request is created the GitHub action for Terraform plan will execute
2. When the pull request is merged, the GitHub action for Terraform apply will execute
