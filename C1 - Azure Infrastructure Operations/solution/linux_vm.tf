

# Create (and display) an SSH key
resource "tls_private_key" "bastian_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "azurerm_network_interface" "linux_ni" {
  count               = var.linux_vms_spec["vm_count"]
  name                =  "nic_${var.linux_vms_spec["vm_name_prefix"]}_${count.index}"
  location            = azurerm_resource_group.rg_web.location
  resource_group_name = azurerm_resource_group.rg_web.name
  # Assign the created security group
  #network_security_group_id = azurerm_network_security_group.allow_access.id

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface_security_group_association" "web-sga" {
  count               = var.linux_vms_spec["vm_count"]
  network_interface_id      = element(azurerm_network_interface.linux_ni, count.index).id
  network_security_group_id = azurerm_network_security_group.allow_access.id
}

resource "azurerm_managed_disk" "pool_mngd_disk" {
  count                = var.linux_vms_spec["vm_count"]
  name                 = "dsk_${var.linux_vms_spec["vm_name_prefix"]}_${count.index}"
  location             = azurerm_resource_group.rg_web.location
  resource_group_name  = azurerm_resource_group.rg_web.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"

  tags = {
    environment = "Production"
  }
}



data "azurerm_image" "packerimage" {
  name                = "myPackerImage"
  resource_group_name = azurerm_resource_group.rg_web.name
}

resource "azurerm_linux_virtual_machine" "web_linux" {
  # How many 
  count                         = var.linux_vms_spec.vm_count
  name                          = format("vm_%s_%s", var.linux_vms_spec["vm_name_prefix"], count.index)
  location                      = azurerm_resource_group.rg_web.location
  resource_group_name           = azurerm_resource_group.rg_web.name
  network_interface_ids         = [element(azurerm_network_interface.linux_ni, count.index).id, ]
  size                          = var.linux_vms_spec["vm_size"]
 

 source_image_id = data.azurerm_image.packerimage.id

 os_disk {
    name                  = "${var.prefix}-osdisk"
    storage_account_type  = "Standard_LRS"
    caching               = "ReadWrite"
  }


  admin_username = var.linux_vms_spec["vm_username"]
  admin_ssh_key {
    username   = var.linux_vms_spec["vm_username"]
    public_key = tls_private_key.bastian_ssh.public_key_openssh
  }
  tags = {
    created     = var.linux_vms_spec["vm_created_by"]
    team        = var.linux_vms_spec["vm_team_name"]
    environment = var.linux_vms_spec["vm_env_type"]
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "pool_mngd_disk_attachment" {
  count              = var.linux_vms_spec["vm_count"]
  managed_disk_id    = element(azurerm_managed_disk.pool_mngd_disk, count.index).id
  virtual_machine_id = element(azurerm_linux_virtual_machine.web_linux, count.index).id
  lun                = "10"
  caching            = "ReadWrite"
}