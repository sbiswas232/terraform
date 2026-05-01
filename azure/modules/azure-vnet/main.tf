# Resource Group for Azure Virtual Network
resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-rg"
  location = var.location
  tags = {
    Project     = "${var.project}-rg"
    Environment = "${terraform.workspace}"
  }
}

# Create Virtual Network vnet
resource "azurerm_virtual_network" "vnet" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = "${var.project}-vnet"
  address_space       = [var.vnet-cidr]
  tags = {
    Project     = "${var.project}-vnet"
    Environment = "${terraform.workspace}"
  }
}

# Create Two Subnet for Virtual Network vnet
resource "azurerm_subnet" "subnet" {
  count                = 2
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(tolist(azurerm_virtual_network.vnet.address_space)[0], 8, count.index +1)]
  name                 = "${var.project}-vnet-subnet${count.index + 1}"
}