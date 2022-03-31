variable "name" {
}

variable "rgname" {
}

variable "location" {
}

variable "agent_count" {
}

variable "vm_size" {
}

variable "dns_prefix" {
    default = "tamopsdns"
}

variable "kubernetes_cluster_rbac_enabled" {
  default = "true"
}

variable "aks_admins_group_object_id" {
  default = "e97b6454-3fa1-499e-8e5c-5d631e9ca4d1"
}

variable "addons" {
  description = "Defines which addons will be activated."
  type = object({
    azure_policy         = bool
    ingress_application_gateway = bool
  })
}

variable aks_subnet {
}

variable agic_subnet_id {
}

variable "environment" {
}

variable "acr_name" {
}
