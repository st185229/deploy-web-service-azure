resource "azurerm_resource_group" "rg_web" {
  name     = "${var.prefix}-rg"
  location = var.location
}
