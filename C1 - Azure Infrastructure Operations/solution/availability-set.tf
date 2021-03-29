
# Availability set , this is assigned to the VM in linux_vm.tf - resource "azurerm_linux_virtual_machine" "web_linux"
resource "azurerm_availability_set" "web-svc-vm-avl-set" {
  name                = "webbackendavailabilityset"
  location            = azurerm_resource_group.rg_web.location
  resource_group_name = azurerm_resource_group.rg_web.name

  tags = {
    environment = "Production"
  }
}
