
resource "azurerm_availability_set" "web-svc-vm-avl-set" {
  name                = "acceptanceTestAvailabilitySet1"
  location            = azurerm_resource_group.rg_web.location
  resource_group_name = azurerm_resource_group.rg_web.name

  tags = {
    environment = "Production"
  }
}
