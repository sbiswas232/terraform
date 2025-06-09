# Create a Network Security Group(nsg1) for vnet1 
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
    name                       = "allow-icmp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "172.16.64.0/20"
    destination_address_prefix = "*"
  }
}

# Associate the NSG(nsg1) with the Subnet(sn1-public)
resource "azurerm_subnet_network_security_group_association" "sn1" {
  subnet_id                 = azurerm_subnet.subnet[0].id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

# Create a Public IP address for Subnet(sn1-public)
resource "azurerm_public_ip" "pip1" {
  name                = "${var.project}-pip1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  ip_version          = "IPv4"
  sku                 = "Standard"
  zones               = ["3"]
}

# Create  Network Interface(nic1)
resource "azurerm_network_interface" "nic1" {
  name                = "${var.project}-nic1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.project}-pip1"
    subnet_id                     = azurerm_subnet.subnet[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip1.id
  }
}

# Create Virtual Machine with Subnet(sn1),NIC1 & Password Authentication
resource "azurerm_linux_virtual_machine" "sn1vm" {
  name                            = "${var.project}-${var.subnet_name[0]}-${var.vm_name[0]}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.password_authentication
  zone                            = 3
  tags = {
    "Project"     = var.project
    "Environment" = var.tag_name[0]
  }
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

# Create a Network Security Group(nsg2) for vnet2
resource "azurerm_network_security_group" "nsg2" {
  name                = "${var.project}-nsg2"
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
    name                       = "allow-icmp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "172.16.32.0/20"
    destination_address_prefix = "*"
  }
}

# Associate the NSG(nsg2) with the Subnet(sn2)
resource "azurerm_subnet_network_security_group_association" "sn2" {
  subnet_id                 = azurerm_subnet.subnet[3].id
  network_security_group_id = azurerm_network_security_group.nsg2.id
}

# Create  Network Interface(nic2)
resource "azurerm_network_interface" "nic2" {
  name                = "${var.project}-nic2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.project}-pip2"
    subnet_id                     = azurerm_subnet.subnet[3].id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create Virtual Machine with Subnet(sn2),nic2 & Password Authentication
resource "azurerm_linux_virtual_machine" "sn2vm" {
  name                            = "${var.project}-${var.subnet_name[3]}-${var.vm_name[1]}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.password_authentication
  tags = {
    "Project"     = var.project
    "Environment" = var.tag_name[1]
  }
  network_interface_ids = [
    azurerm_network_interface.nic2.id,
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
