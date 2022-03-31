####################################### VNET #########################################

variable "vnet_name" {
  default = "euroclear-vnet"
  description = "Virtual Network Name"
}

variable "rgname" {
  default = "euroclear-RG"
  description = "Resource Groupe Name"
}

variable "location" {
  default = "westeurope"
  description = "Location of Resources"
}

variable "network_address_space" {
  default = "10.0.0.0/16"
  description = "Virtual Network Address Space"
}

variable "aks_subnet_address_prefix" {
  default = "10.0.1.0/24"
  description = "AKS Subnet Address Prefix"
}

variable "aks_subnet_address_name" {
  default = "K8s_subnet"
  description = "AKS Subnet Name"
}

variable "appgw_subnet_address_prefix" {
  default = "10.0.2.0/24"
  description = "AppGW Subnet Address Prefix"
}

variable "appgw_subnet_address_name" {
  default = "AppGTW_subnet"
  description = "AppGW Subnet Name"
}

variable "environment_common" {
  default = "common"
  description = "Environment"
}

####################################### KUBERNETES ####################################

variable "aks_name" {
  default = "euroclear-K8s"
  description = "AKS Name"
}

variable "agent_count" {
  default = "2"
  description = "AKS Agent Count"
}

variable "vm_size" {
  default = "Standard_D2_v2"
  description = "AKS VM Size"
}

variable "acr_name" {
  default = "euroclearacr"
  description = "ACR Name"
}

variable "environment_hot" {
  default = "hot"
  description = "Environment"
}

########################################## COSMOS DB ####################################

variable "cosmosdb_name" {
  default = "euroclear-cosmosdb"
  description = "Cosmos DB Name"
}

variable "offer_type" {
  default = "Standard"
  description = "Cosmos DB SKU"
}

variable "db_kind" {
  default = "MongoDB"
  description = "DB Kind"
}

variable "failover_location" {
  default = "North Europe"
  description = "Failover Location for DB"
}

########################################## EVENT HUB ####################################

variable "namespace_name" {
  default = "euroclear-namespace"
}

variable "eventhub_name" {
  default = "euroclearTestEventHub"
}

variable "sku" {
  default = "Standard"
}

########################################## FUNCTION APP HOT ####################################

variable "saname" {
  default = "euroclearfunctionsa"
}

variable "tiers" {
  default = "Standard"
}

variable "replication" {
  default = "LRS"
}

variable "planname" {
  default = "euroclear-functionapp-sp"
}

variable "appname_hot" {
  default = "euroclear-functionapp-hot"
}

variable "appname_cold" {
  default = "euroclear-functionapp-cold"
}

variable "environment_cold" {
  default = "cold"
  description = "Environment"
}

########################################## KEYVAULT ####################################

variable "kvname" {
  default = "euroclearkeyvault"
}

########################################## DATABRICKS ####################################

variable "AzureADAppName" {
  default = "databricks_app"
}

variable "clustername" {
  default = "databricks-cluster"
}

