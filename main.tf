terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "location" {
  type    = string
}

variable "prefix" {
  type    = string
}

resource "random_integer" "sa_id" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "rg" {
  name     = "tfdemo-rg"
  location = var.location
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.prefix}stgacct${random_integer.sa_id.id}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_replication_type = "LRS"
  account_tier             = "Standard"
}

output "sa_name" {
  value = azurerm_storage_account.sa.name
}
