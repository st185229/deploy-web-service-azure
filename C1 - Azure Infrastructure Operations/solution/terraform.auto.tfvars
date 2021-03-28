tagging_policy_config = {
  name         = "tagPolicy"
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