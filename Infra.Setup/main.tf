provider "azurerm" {
  version = "2.0.0"
  features {}
  
}

terraform {
  backend "azurerm" {
    resource_group_name   = #{storesourcegroup}#
    storage_account_name  = #{terraformstorageaccount}#
    container_name        = "terraform"
    key                   = "terraform.tfstate"
  }
}


variable "region" {}
variable "rgName" {}
variable "spName" {}
variable "spTier" {}
variable "spSKU" {}
variable "webAppName" {}
variable "appInsightsname" {}
variable "AIlocation" {}

#Create a new resource group
#resource "azurerm_resource_group" "rg" {
#  name     = var.rgName
#  location = var.region
#}

module "appServicePlan" {
    source  = "./modules/appServicePlan"
    spName  = var.spName
    region  = var.region
    rgName  = var.rgName
    spTier  = var.spTier
    spSKU   = var.spSKU
}

module "webApp" {
    source         = "./modules/webApp"
    name           = var.webAppName
    rgName         = var.rgName
    location       = var.region
    spId           = module.appServicePlan.SPID
    appinsightskey = module.appInsights.instrumentation_key
}

module "appInsights" {
    source  = "./modules/appInsights"
    appInsightsname  = var.appInsightsname
    rgName  = var.rgName
    location  = var.AIlocation
}

output "ServicePlanName" {
  value = module.appServicePlan.ServicePlanName
}
output "WebAppName" {
  value = module.webApp.WebAppName
}
output "WebAppURL" {
  value = module.webApp.WebAppURL
}
output "WebAppSlotName" {
  value = module.webApp.WebAppSlotName
}
output "WebAppSlotURL" {
  value = module.webApp.WebAppSlotURL
}
output "instrumentation_key" {
  value = module.appInsights.instrumentation_key
}