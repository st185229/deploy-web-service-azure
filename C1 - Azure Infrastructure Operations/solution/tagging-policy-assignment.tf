data "azurerm_subscription" "current" {
}

resource "azurerm_policy_assignment" "tagging-policy-asn" {
  name                 = var.tagging_policy_config_assn["name"]
  scope                = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.tagging-policy.id
  description          = var.tagging_policy_config_assn["description"]
  display_name         = var.tagging_policy_config_assn["display_name"]


  metadata = <<METADATA
    {
    "category": "General"
    }
METADATA

  parameters = <<PARAMETERS
{
  "tagName": {
          "value": "${var.tagging_policy_config_assn["tag_name"]}"
      }
}
PARAMETERS

  depends_on = [azurerm_policy_definition.tagging-policy]
}