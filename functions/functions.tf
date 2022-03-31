resource "azurerm_storage_account" "storage_account" {
  name                     = var.saname
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = var.tiers 
  account_replication_type = var.replication
  tags = {
    Environment = var.environment_common
  }  
}

resource "azurerm_app_service_plan" "service_plan" {
  name                = var.planname
  location            = var.location
  resource_group_name = var.rgname 

  sku {
    tier = "Standard"
    size = "S1"
  }
  tags = {
    Environment = var.environment_common
  }  
}

resource "azurerm_function_app" "function_app_hot" {
  name                       = var.appname_hot
  location                   = var.location
  resource_group_name        = var.rgname
  app_service_plan_id        = azurerm_app_service_plan.service_plan.id
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  tags = {
    Environment = var.environment_hot
  } 
}

resource "azurerm_function_app" "function_app_cold" {
  name                       = var.appname_cold
  location                   = var.location
  resource_group_name        = var.rgname
  app_service_plan_id        = azurerm_app_service_plan.service_plan.id
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  tags = {
    Environment = var.environment_cold
  } 
}