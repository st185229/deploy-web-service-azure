
prefix         = "udacity"
location       = "EastUS"
packerimage_rg = "packer-rg"

tagging_policy_config = {
  name         = "tagging-policy"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Policy ensures all indexed resources the subscription have tags and deny deployment if they do not."
  category : "General"
}

tagging_policy_config_assn = {
  name         = "tagging-policy-assignment"
  display_name = "enforce tags"
  description  = "Assign policy ensures all indexed resources the subscription have tags and deny deployment if they do not"
  tag_name     = "tag enforcement"
}

network_address_spaces = {
  vnet_address_spaces   = ["10.0.2.0/24"]
  subnet_address_spaces = ["10.0.2.0/24"]
}

linux_vms_spec = {
  vm_count       = 2
  vm_name_prefix = "udcweb"
  vm_size        = "Standard_F2"
  vm_username    = "authentic"
  # ---------------OS related start
  #vm_publisher = "Canonical"
  #vm_offer     = "UbuntuServer"
  #vm_sku       = "18.04-LTS"
  #vm_version   = "latest"

  vm_created_by = "suresh thomas"
  vm_team_name  = "udacity"
  vm_env_type   = "production"
}

