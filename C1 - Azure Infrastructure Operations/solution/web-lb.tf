# Creates public IP of the load balancer which can be accesed from outside
resource "azurerm_public_ip" "web-svc-lb-ip" {
  name                = "PublicIPForLB"
  resource_group_name = azurerm_resource_group.rg_web.name
  location            = azurerm_resource_group.rg_web.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

# Load balancer
resource "azurerm_lb" "web-svc-lb" {
  name = "WebServiceLB"

  location            = azurerm_resource_group.rg_web.location
  resource_group_name = azurerm_resource_group.rg_web.name

  frontend_ip_configuration {
    name = "PublicIPAddress"
    # Refer networks.tf . The public IP created network.tf is bound to LB
    public_ip_address_id = azurerm_public_ip.web-svc-lb-ip.id
  }
}
# Backend pool
resource "azurerm_lb_backend_address_pool" "web-svc-lb-backend-pool" {
  loadbalancer_id = azurerm_lb.web-svc-lb.id
  name            = "BackEndAddressPool"
}
#  Health probe - its good practice , See line 84 on linux_vm.tf , this details the association  through azurerm_network_interface_backend_address_pool_association
resource "azurerm_lb_probe" "web_svc_health_probe" {
  resource_group_name = azurerm_resource_group.rg_web.name
  loadbalancer_id     = azurerm_lb.web-svc-lb.id
  name                = "web-http-probe"
  port                = var.web_svc_port
}