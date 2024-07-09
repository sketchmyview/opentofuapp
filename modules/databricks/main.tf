resource "azurerm_databricks_workspace" "example" {
  name                        = "${var.dbr-name}-dbw"
  resource_group_name         = var.dbr-rg
  location                    = var.dbr-location
  sku                         = "trial"
  managed_resource_group_name = "${var.dbr-name}-mdbw"
}
