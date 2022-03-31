provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

terraform {
    backend "azurerm" {
      resource_group_name = "Max_RG"   
      storage_account_name = "terraformmaxeuroclear"
      container_name = "aksdeployazuredevops"
      key = "euroclear.tfstate"
    }
    required_providers {
      databricks = {
      source  = "databrickslabs/databricks"
      version = "0.5.3"
      }
    }
}