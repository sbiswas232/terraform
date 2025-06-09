# Resource Group for Azure vnet1 & vnet2 Peering Connection 
resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-${var.resource_group_name}"
  location = var.location
  tags = {
    "Project" = var.project
  }
}

# Create  two Virtual Network(vnet1 & vnet2)
resource "azurerm_virtual_network" "vnet" {
  count               = length(var.vnet_name)
  name                = "${var.project}-${var.vnet_name[count.index]}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet_address[count.index]]
  tags = {
    "Project"     = var.project
    "Environment" = var.tag_name[count.index]
  }
}

# Create four Subnet(two with vnet1) & (two with vnet2)
resource "azurerm_subnet" "subnet" {
  count                = length(var.subnet_name)
  name                 = "${var.project}-${var.subnet_name[count.index]}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = element(azurerm_virtual_network.vnet[*].name, count.index % length(azurerm_virtual_network.vnet))
  address_prefixes     = [var.subnet_address[count.index]]
}

# Create Peerning Connection for vnet1
resource "azurerm_virtual_network_peering" "peer1" {
  name                      = "${var.project}-${var.peering_connection_name[0]}"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet[0].name
  remote_virtual_network_id = azurerm_virtual_network.vnet[1].id
}

# Create Peerning Connection for vnet2
resource "azurerm_virtual_network_peering" "peer2" {
  name                      = "${var.project}-${var.peering_connection_name[1]}"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet[1].name
  remote_virtual_network_id = azurerm_virtual_network.vnet[0].id
}