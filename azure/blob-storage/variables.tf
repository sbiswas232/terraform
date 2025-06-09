variable "location" {
  type    = list(string)
  default = ["central india", "eastus"]
}

variable "resource_group_name" {
  type    = string
  default = "aiclass24may"
}

variable "storage_account_name" {
  type    = list(string)
  default = ["souvikaiclass24may", "souvikaiclass25may"]
}

variable "storage_container_name" {
  type    = list(string)
  default = ["container24may", "container25may"]
}

variable "tag_name" {
  type    = list(string)
  default = ["Dev", "Prod"]
}

