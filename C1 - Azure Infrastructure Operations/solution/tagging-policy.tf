// Ref https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/Definitions/category/Tags/selectedItem/Definitions
resource "azurerm_policy_definition" "tagging-policy" {
  name         = var.tagging_policy_config["name"]
  policy_type  = var.tagging_policy_config["policy_type"]
  mode         = var.tagging_policy_config["mode"]
  display_name = var.tagging_policy_config["display_name"]

  metadata = <<METADATA
    {
     "version": "1.0.1",
     "category": "Tags"
    }

METADATA

  policy_rule = <<POLICY_RULE
    {
    "if": {
      "not": {
        "field": "[concat('tags[', parameters('tagName'), ']')]",
        "exists": "false"
      }
    },
    "then": {
      "effect": "deny"
    }
  }
POLICY_RULE


  parameters = <<PARAMETERS
    {
   "tagName": {
        "type": "String",
        "metadata": {
            "displayName": "Tag Name",
            "description": "Name of the tag, such as 'environment'"
        }
    }
  }
PARAMETERS
}