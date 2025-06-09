variable "project" {
  type    = string
  default = "azure04june25"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "resource_group_name" {
  type    = string
  default = "vnetpeer-rg"
}

variable "vnet_name" {
  type    = list(string)
  default = ["vnet1", "vnet2"]
}

variable "vnet_address" {
  type    = list(string)
  default = ["172.16.32.0/20", "172.16.64.0/20"]
}

variable "subnet_name" {
  type    = list(string)
  default = ["sn1-public", "sn2-public", "sn1-private", "sn2-private"]
}

variable "subnet_address" {
  type    = list(string)
  default = ["172.16.32.0/24", "172.16.64.0/24", "172.16.33.0/24", "172.16.65.0/24"]
}

variable "tag_name" {
  type    = list(string)
  default = ["Dev", "Prod"]
}

variable "peering_connection_name" {
  type    = list(string)
  default = ["peer1", "peer2"]
}

variable "vm_name" {
  type    = list(string)
  default = ["vm1", "vm2"]
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "password_authentication" {
  type    = bool
  default = "false"
}

variable "admin_username" {
  type    = string
  default = "sysadmin"
}

variable "admin_password" {
  type    = string
  default = ""
}


