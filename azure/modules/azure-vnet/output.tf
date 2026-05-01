output "subnet-cidr" {
  value = [for i in azurerm_subnet.subnet : i.address_prefixes]
}