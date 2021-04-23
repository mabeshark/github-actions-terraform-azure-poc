resource "random_string" "random" {
  length  = 15
  special = false
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv0test" {
  name                = "demo-${random_string.random.result}-kv"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}