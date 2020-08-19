variable "username" {
  type    = string
  default = ""
}

variable "password" {
  type    = string
  default = ""
}

variable "controller_ip" {
  type    = string
  default = ""
}

variable "azure_transit_cidr1" {
  default = ""
}

variable "azure_region1" {
  default = ""
}

variable "azure_account_name" {
  default = ""
}

variable "azure_region_alias" {
  default = ""
}

variable "azure_gw_size" {
  default = ""
}

variable "firewall_image" {
  default = ""
}

variable "firewall_image_version" {
  default = ""
}

variable "ha_gw" {
}

variable "azure_spoke_params" {
  description = "Azure Spoke Parameters: azure_spoke_vpc_name, azure_spoke_subnet_cidr, azure_spoke_region, azure_spoke_gw_name"
  type = map(object({
    azure_spoke_vpc_name = string
    azure_spoke_vpc_cidr = string
    azure_spoke_region   = string
    azure_spoke_gw_name  = string
  }))
}


