# Creating Azure Blob Storage Account

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location[1]
}

resource "azurerm_storage_account" "aistorage" {
  count                    = length(var.storage_account_name)
  name                     = var.storage_account_name[count.index]
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    Environment = var.tag_name[count.index]
  }
}

resource "azurerm_storage_container" "aicontainer" {
  count                 = length(var.storage_container_name)
  name                  = var.storage_container_name[count.index]
  storage_account_id    = azurerm_storage_account.aistorage[count.index].id
  container_access_type = "container"
}