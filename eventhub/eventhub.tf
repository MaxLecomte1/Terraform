resource "azurerm_eventhub_namespace" "namespace" {
  name                = var.namespace_name
  location            = var.location
  resource_group_name = var.rgname
  sku                 = var.sku 
  capacity            = 1

  tags = {
    environment = "Production"
  }
}

resource "azurerm_eventhub" "example" {
  name                = var.eventhub_name
  namespace_name      = var.namespace_name
  resource_group_name = var.rgname
  partition_count     = 2
  message_retention   = 1
  depends_on          = [azurerm_eventhub_namespace.namespace]
}