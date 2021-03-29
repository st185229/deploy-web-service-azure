variable "tagging_policy_config" {
  description = "tagging policy "
  type        = map(string)
}
variable "tagging_policy_config_assn" {
  description = "tagging policy assignemnets to subscription"
  type        = map(string)
}
variable "prefix" {
  description = "The prefix which should be used for all resources"
  default     = "udacity"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "EastUS"
}

variable "network_address_spaces" {
  description = "Address spaces for virtual networks and subnets"
  type        = map(list(string))
}