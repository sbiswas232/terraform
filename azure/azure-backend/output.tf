output "storage_account_name" {
  value = azurerm_storage_account.my_storage[*].name
}