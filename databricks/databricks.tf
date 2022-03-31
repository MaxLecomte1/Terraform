terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.5.3"
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_databricks_workspace" "euroclear-workspace" {
  name                = "databricks-test"
  resource_group_name = var.rgname
  location            = var.location
  sku                 = "standard"

  tags = {
    Environment = var.environment
  }
}

resource "azuread_application" "app" {
  display_name = var.AzureADAppName
}

resource "azuread_service_principal" "app" {
  application_id               = azuread_application.app.application_id
  app_role_assignment_required = false
}

resource "azuread_service_principal_password" "app" {
  service_principal_id = azuread_service_principal.app.id
}

resource "azurerm_role_assignment" "app" {
  scope                = azurerm_databricks_workspace.euroclear-workspace.id
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.app.object_id
}

provider "databricks" {
    azure_workspace_resource_id   = azurerm_databricks_workspace.euroclear-workspace.id
    azure_client_id               = azuread_application.app.application_id
    azure_client_secret           = azuread_service_principal_password.app.value
    azure_tenant_id               = data.azurerm_client_config.current.tenant_id
}

data "databricks_node_type" "smallest" {
  local_disk = true
  depends_on = [resource.azurerm_databricks_workspace.euroclear-workspace]
}

data "databricks_spark_version" "latest_lts" {
  gpu = true
  ml  = true  
  depends_on = [resource.azurerm_role_assignment.app]
}

resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = var.clustername
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20
  autoscale {
    min_workers = 1
    max_workers = 50
  }
  spark_conf = {
    "spark.databricks.io.cache.enabled" : true,
    "spark.databricks.io.cache.maxDiskUsage" : "50g",
    "spark.databricks.io.cache.maxMetaDataCache" : "1g"
  }
  depends_on = [
    resource.azurerm_databricks_workspace.euroclear-workspace,
    resource.azurerm_role_assignment.app
  ]
}