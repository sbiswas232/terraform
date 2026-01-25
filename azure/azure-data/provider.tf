terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.27.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription
  features {}
}
