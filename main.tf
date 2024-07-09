resource "random_string" "app_id" {
  length           = 6
  special          = true
  override_special = "/@£$"
  lower            = true
  upper            = false
}

module "smv-app-rg" {
  source = "./modules/resource-group"

  rg-name     = "demo${random_string.app_id.result}rg"
  rg-location = var.app-location
}

module "smv-app-adls" {
  source = "./modules/data-lake"

  st-name     = "demo${random_string.app_id.result}adls"
  st-rg       = module.smv-app-rg.rg_output.name
  st-location = var.app-location

  depends_on = [module.smv-app-rg]
}

module "smv-app-kv" {
  source = "./modules/keyvault"

  kv-name     = "demo${random_string.app_id.result}kv"
  kv-rg       = module.smv-app-rg.rg_output.name
  kv-location = var.app-location
  tenant_id   = var.tenant_id
}

module "smv-app-databricks" {
  source = "./modules/databricks"

  dbr-name     = "demo${random_string.app_id.result}"
  dbr-rg       = module.smv-app-rg.rg_output.name
  dbr-location = var.app-location
}