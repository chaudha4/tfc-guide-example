provider "azurerm" {
  features {}

  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  # You need to provide the following if your envirnment does not have
  # these set. Normally you will provide these in the terraform cloud, not here.
  #subscription_id = "."
  #client_id       = "."
  #client_secret   = "."
  #tenant_id       = "."
}

resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-network"
  resource_group_name = "${azurerm_resource_group.example.name}"
  location            = "${azurerm_resource_group.example.location}"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  virtual_network_name = "${azurerm_virtual_network.example.name}"
  resource_group_name  = "${azurerm_resource_group.example.name}"
  address_prefixes     = ["10.0.1.0/24"]
}