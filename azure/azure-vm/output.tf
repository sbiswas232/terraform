output "subnet1_id" {
  value = azurerm_subnet.subnet1.address_prefixes
}

output "subnet2_id" {
  value = azurerm_subnet.subnet2.address_prefixes
}

output "subnet1vm1_public_ip" {
  value = azurerm_linux_virtual_machine.subnet1vm.public_ip_address
}