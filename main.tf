terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.10.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "f5248d64-e3e0-4b1c-80e3-ce984c44da3b"
}

# The azurerm_subscription resource isn't necessary unless you're managing subscriptions
# You can remove this block if you're just using an existing subscription
# resource "azurerm_subscription" "example" {
#   alias             = "Azure"
#   subscription_name = "Azure subscription 1"
#   subscription_id   = "f5248d64-e3e0-4b1c-80e3-ce984c44da3b"
# }

resource "azurerm_resource_group" "example" {
  name     = "myterraformAZ900"
  location = "West US"
}

resource "azurerm_storage_account" "example" {
  name                     = "myterraformazstorage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}