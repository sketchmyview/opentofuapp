resource "azurerm_storage_account" "data_platform_storage_accounts" {
  name                     = var.st-name
  resource_group_name      = var.st-rg
  location                 = var.st-location
  account_tier             = local.account_tier
  account_replication_type = local.account_replication_type
  account_kind             = local.account_kind
  is_hns_enabled           = local.is_hns_enabled

  routing {
    publish_internet_endpoints  = false
    publish_microsoft_endpoints = true
  }

  blob_properties {
    delete_retention_policy {
      days = 30
    }
    container_delete_retention_policy {
      days = 7
    }
  }
}

resource "azurerm_storage_container" "raw" {
  for_each = toset(local.default_storage_containers)

  name                  = each.value
  storage_account_name  = azurerm_storage_account.data_platform_storage_accounts.name
  container_access_type = "private"
}
