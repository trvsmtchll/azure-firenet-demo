# Simple Azure Transit FireNet Demo

# Azure Transit FireNet Module
module "transit_firenet_1" {
  source                 = "terraform-aviatrix-modules/azure-transit-firenet/aviatrix"
  version                = "1.0.1"
  cidr                   = var.azure_transit_cidr1
  region                 = var.azure_region1
  azure_account_name     = var.azure_account_name
  firewall_image         = var.firewall_image
  firewall_image_version = var.firewall_image_version
}

# Aviatrix Azure Spoke VNETs
resource "aviatrix_vpc" "azure_spoke_vnet" {
  for_each             = var.azure_spoke_params
  cloud_type           = 8
  account_name         = var.azure_account_name
  name                 = each.value.azure_spoke_vpc_name
  region               = each.value.azure_spoke_region
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  cidr                 = each.value.azure_spoke_vpc_cidr
}

# Aviatrix Azure Spoke Gateways
resource "aviatrix_spoke_gateway" "azure_spoke_gw" {
  for_each           = var.azure_spoke_params
  cloud_type         = 8
  account_name       = var.azure_account_name
  gw_name            = each.value.azure_spoke_gw_name
  vpc_id             = aviatrix_vpc.azure_spoke_vnet[each.key].vpc_id
  vpc_reg            = each.value.azure_spoke_region
  gw_size            = var.azure_gw_size
  subnet             = aviatrix_vpc.azure_spoke_vnet[each.key].subnets[0].cidr
  enable_active_mesh = true
  transit_gw         = module.transit_firenet_1.transit_gateway.gw_name
}

