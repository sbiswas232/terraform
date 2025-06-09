output "storage_account_name" {
  value = [for i in azurerm_storage_account.aistorage : i.name]
}

output "storage_container_name" {
  value = azurerm_storage_container.aicontainer[*].name
}