resource "azurerm_network_security_group" "allow_access" {
  name                = "deploy-web-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_web.name

  tags = {
    environment = "azure web service"
  }
}

#THe above NSG is assigned to interface cards in resource "azurerm_network_interface_security_group_association" "web-sga" , Refer linux_vm

resource "azurerm_network_security_rule" "allow_access_from_intenet_80" {
  name                        = "HTTP_80"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = var.web_svc_port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_web.name
  network_security_group_name = azurerm_network_security_group.allow_access.name
}

resource "azurerm_network_security_rule" "allow_access_from_vm_on_subnet" {
  name                         = "access_from_same_subnet"
  priority                     = 1002
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "*"
  source_address_prefixes      = var.network_address_spaces["vnet_address_spaces"]
  destination_address_prefixes = var.network_address_spaces["vnet_address_spaces"]
  resource_group_name          = azurerm_resource_group.rg_web.name
  network_security_group_name  = azurerm_network_security_group.allow_access.name
}

