resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-rg"
  location = var.locations[0]
  tags     = local.common_tag
}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-network"
  address_space       = [var.network_address]
  location            = var.locations[0]
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.common_tag
}

# Create Subnet1
resource "azurerm_subnet" "subnet1" {
  name                 = "${var.project}-subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet1_address]
}

# Create Subnet2
resource "azurerm_subnet" "subnet2" {
  name                 = "${var.project}-subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet2_address]
}

# Create a Network Security Group(NSG)
resource "azurerm_network_security_group" "nsg1" {
  name                = "${var.project}-nsg1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate the NSG with the Subnet1
resource "azurerm_subnet_network_security_group_association" "subnet1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

# Create a Public IP address for Subnet1
resource "azurerm_public_ip" "publicip" {
  name                = "${var.project}-publicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  ip_version          = "IPv4"
  sku                 = "Standard"
}

# Create  Network Interface(nic1)
resource "azurerm_network_interface" "nic1" {
  name                = "${var.project}-nic1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.project}-public"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

# Create Virtual Machine with Subnet1,NIC1 & Password Authentication
resource "azurerm_linux_virtual_machine" "subnet1vm" {
  name                            = "${var.project}-vm1"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.password_authentication
  zone                            = var.availability_zone
  tags                            = local.common_tag
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
