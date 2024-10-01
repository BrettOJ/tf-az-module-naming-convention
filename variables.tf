
variable "resource_type" {
  type        = string
  description = "(Required) Specify the type of azure resource"
}

variable "name_format" {
  type        = string
  description = "(Required) Specify the name format of azure resource"
}

variable "azlimits" {
  description = "limit for resources"
  default = {
    "rg"          = 90
    "kv"          = 24
    "st"          = 24
    "vnet"        = 64
    "nsg"         = 80
    "vsubnet"     = 80
    "nic"         = 80
    "linuxvm"     = 64
    "windowsvm"   = 15
    "functionapp" = 60
    "lb"          = 80
    "lbrule"      = 80
    "evh"         = 50
    "la"          = 63
    "gen"         = 24
  }
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention parameters"
}
