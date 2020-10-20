variable "appInsightsname" {}
variable "location" {}
variable "rgName" {}


resource "azurerm_application_insights" "appInsights" {
  name                = var.appInsightsname
  location            = var.location
  resource_group_name = var.rgName
  application_type    = "web"
  retention_in_days   = 90
}

output "instrumentation_key" {
  value = azurerm_application_insights.appInsights.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.appInsights.app_id
}