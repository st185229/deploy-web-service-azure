
prefix   = "udacity"
location = "EastUS"

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

