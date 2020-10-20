variable "region" {}
variable "rgName" {}
variable "spName" {}
variable "spTier" {}
variable "spSKU" {}

resource "azurerm_app_service_plan" "serviceplan" {
  name                = var.spName
  location            = var.region
  resource_group_name = var.rgName

  sku {
    tier = var.spTier
    size = var.spSKU
  }
}

output "SPID" {
  value = azurerm_app_service_plan.serviceplan.id
}

output "ServicePlanName" {
  value = azurerm_app_service_plan.serviceplan.name
}