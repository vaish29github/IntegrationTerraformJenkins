provider "azurerm" {
  features {}
  subscription_id = "8a50193c-553b-4b02-ab38-8efe93f3e32e"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-jenkins"
  location = "East US"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "myapp-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "webapijenkins2912"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version = "DOTNET|8.0"
}
}