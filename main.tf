resource "azurerm_resource_group" "vnet_resource_group" {
  name     = var.rgname
  location = var.location
  
  tags = {
    Environment = var.environment
  }
}


module "vnet" {
  source                      = "./modules/vnet"
  name                        = var.vnet_name
  rgname                      = var.rgname
  location                    = var.location
  network_address_space       = var.network_address_space
  aks_subnet_address_prefix   = var.aks_subnet_address_prefix
  aks_subnet_address_name     = var.aks_subnet_address_name
  appgw_subnet_address_prefix = var.appgw_subnet_address_prefix
  appgw_subnet_address_name   = var.appgw_subnet_address_name
  environment                 = var.environment_common
}

module "aks" {
  source                     = "./modules/aks"
  name                       = var.aks_name
  rgname                     = var.rgname 
  agent_count                = var.agent_count
  vm_size                    = var.vm_size
  location                   = var.location
  acr_name                   = var.acr_name
  aks_subnet                 = module.vnet.aks_subnet_id
  agic_subnet_id             = module.vnet.appgw_subnet_id
  environment                = var.environment_hot
  depends_on                  = [module.vnet]

  addons = {
    azure_policy                = false
    ingress_application_gateway = true
  }

}

module "cosmosdb" {
  source                      = "./modules/cosmosdb"
  name                        = var.cosmosdb_name
  location                    = var.location
  rgname                      = var.rgname
  offer_type                  = var.offer_type
  db_kind                     = var.db_kind
  failover_location           = var.failover_location
  environment                 = var.environment_hot
  depends_on                  = [module.vnet]
} 

module "eventhub" {
  source                      = "./modules/eventhub"
  namespace_name              = var.namespace_name
  eventhub_name               = var.eventhub_name
  location                    = var.location
  rgname                      = var.rgname
  sku                         = var.sku
  depends_on                  = [module.vnet]
}

module "function" {
  source                      = "./modules/functions"
  saname                      = var.saname
  rgname                      = var.rgname
  location                    = var.location
  tiers                       = var.tiers
  replication                 = var.replication
  planname                    = var.planname
  appname_hot                 = var.appname_hot
  appname_cold                = var.appname_cold
  environment_hot             = var.environment_hot
  environment_cold            = var.environment_cold
  environment_common          = var.environment_common
  depends_on                  = [module.vnet]
}

module "keyvault" {
  source                      = "./modules/keyvault"
  kvname                      = var.kvname
  rgname                      = var.rgname
  location                    = var.location
  environment                 = var.environment_hot
  depends_on                  = [module.vnet]
}

module "databricks" {
  source                      = "./modules/databricks"
  rgname                      = var.rgname
  location                    = var.location
  AzureADAppName              = var.AzureADAppName
  clustername                 = var.clustername
  environment                 = var.environment_cold
}