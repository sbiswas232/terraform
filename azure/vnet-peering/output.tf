output "sn1vm_publicip" {
  value = azurerm_linux_virtual_machine.sn1vm.public_ip_address
}

output "sn1vm_privateip" {
  value = azurerm_linux_virtual_machine.sn1vm.private_ip_address
}

output "sn2vm_privateip" {
  value = azurerm_linux_virtual_machine.sn2vm.private_ip_address
}