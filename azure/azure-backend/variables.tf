variable "resource_group_name" {
  type    = string
  default = "class12may"
}

variable "location" {
  type    = list(string)
  default = ["eastus", "westus"]
}

variable "storage_account" {
  type    = list(string)
  default = ["souvikstorage16may", "souvikstorage17may"]
}

variable "tag_name" {
  type    = string
  default = "test"
}