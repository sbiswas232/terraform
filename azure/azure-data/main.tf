resource "azurerm_storage_account" "project25-01-storage" {
  name                     = "project250126storage"
  resource_group_name      = data.azurerm_resource_group.project25-01.name
  location                 = data.azurerm_resource_group.project25-01.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    Name = "project25-01-storage"
  }
}

resource "azurerm_storage_container" "project25-01-container" {
  name                  = "project25-01-container"
  storage_account_id    = azurerm_storage_account.project25-01-storage.id
  container_access_type = "container"
}
