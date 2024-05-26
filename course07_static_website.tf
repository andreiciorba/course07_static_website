terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = "West Europe"
}

variable "rg_name" {
  default = "example-resources-sw"
}

resource "azurerm_storage_account" "storage_account" {
  name = "storageacc202405sw"
  resource_group_name = azurerm_resource_group.example.name
  location = azurerm_resource_group.example.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"

  static_website {
    index_document = "index.html"
    error_404_document = "error.html"
  }
}