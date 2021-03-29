resource "azurerm_virtual_network" "net_web" {
  name                = "${var.prefix}-network"
  address_space       = var.network_address_spaces["vnet_address_spaces"]
  location            = azurerm_resource_group.rg_web.location
  resource_group_name = azurerm_resource_group.rg_web.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg_web.name
  virtual_network_name = azurerm_virtual_network.net_web.name
  address_prefixes     = var.network_address_spaces["subnet_address_spaces"]
}
