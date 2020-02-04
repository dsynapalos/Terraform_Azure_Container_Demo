variable "subscription_id"{}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "resource_group_name" {}
variable "resource_group_location" {}
variable "container_group_name" {}
variable "container_name" {}
variable "container_image" {}

provider "azurerm" {

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "docker_testing" {

  name     = var.resource_group_name
  location = var.resource_group_location

}

resource "azurerm_container_group" "docker_testing" {

  name                = var.container_group_name
  location            = azurerm_resource_group.docker_testing.location
  resource_group_name = azurerm_resource_group.docker_testing.name
  ip_address_type     = "public"
  dns_name_label      = "aci-label"
  os_type             = "Linux"

  container {
    
    name   = var.container_name
    image  = var.container_image
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 80
      protocol = "TCP"

    }
  }

  tags = {
    environment = "docker_testing"
  }
}
