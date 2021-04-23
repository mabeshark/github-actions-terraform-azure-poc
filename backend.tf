terraform {
  backend "azurerm" {
    resource_group_name  = "github-actions-terraform-poc-rg"
    storage_account_name = "mabegithubtfstatestore"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}
