resource "azurerm_key_vault" "data_platform_key_vault" {
  name                        = var.kv-name
  resource_group_name         = var.kv-rg
  location                    = var.kv-location
  tenant_id                   = var.tenant_id
  sku_name                    = local.akv_sku_name
  enabled_for_disk_encryption = true

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }
}
