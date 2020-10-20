variable "name" {}
variable "location" {}
variable "rgName" {}
variable "spId" {}
variable "appinsightskey" {}

resource "azurerm_app_service" "webApp" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rgName
  app_service_plan_id = var.spId
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.appinsightskey
  }
}

resource "azurerm_app_service_slot" "webApp" {
  name                = "staging"
  app_service_name    = azurerm_app_service.webApp.name
  location            = azurerm_app_service.webApp.location
  resource_group_name = azurerm_app_service.webApp.resource_group_name
  app_service_plan_id = azurerm_app_service.webApp.app_service_plan_id

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.appinsightskey
  }

}

output "WebAppName" {
  value = azurerm_app_service.webApp.name
}
output "WebAppURL" {
  value = azurerm_app_service.webApp.default_site_hostname
}
output "WebAppSlotName" {
  value = format("%s/%s",azurerm_app_service.webApp.name, azurerm_app_service_slot.webApp.name)
}
output "WebAppSlotURL" {
  value = azurerm_app_service_slot.webApp.default_site_hostname
}