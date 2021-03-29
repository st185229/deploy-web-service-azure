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
resource "azurerm_public_ip" "vm_pub_ip" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.rg_web.name
  location            = var.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}
resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.rg_web.name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pub_ip.id
  }
}

