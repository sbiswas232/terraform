variable "project" {
  type    = string
  default = "DevOps27may"
}

variable "locations" {
  type    = list(string)
  default = ["eastus", "eastus2"]
}

variable "network_address" {
  type    = string
  default = "172.16.0.0/16"
}

variable "subnet1_address" {
  type    = string
  default = "172.16.1.0/24"
}

variable "subnet2_address" {
  type    = string
  default = "172.16.2.0/24"
}

variable "vm_size" {
  type    = string
  default = ""
}

variable "availability_zone" {
  type    = number
  default = 0
}

variable "password_authentication" {
  type    = bool
  default = "false"
}

variable "admin_username" {
  type    = string
  default = ""
}

variable "admin_password" {
  type    = string
  default = ""
}


