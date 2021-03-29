
resource "azurerm_lb" "web-svc-lb" {
  name = "WebServiceLB"

  location            = azurerm_resource_group.rg_web.location
  resource_group_name = azurerm_resource_group.rg_web.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.web-svc-lb-ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "web-svc-lb-backend-pool" {
  loadbalancer_id = azurerm_lb.web-svc-lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "web_svc_health_probe" {
  resource_group_name = azurerm_resource_group.rg_web.name
  loadbalancer_id     = azurerm_lb.web-svc-lb.id
  name                = "web-http-probe"
  port                = var.web_svc_port
}