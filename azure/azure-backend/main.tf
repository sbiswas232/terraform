# Creating Azure Blob Storage Account

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location[0]
}

resource "azurerm_storage_account" "my_storage" {
  count                    = length(var.storage_account)
  name                     = var.storage_account[count.index]
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    name = var.tag_name
  }
}