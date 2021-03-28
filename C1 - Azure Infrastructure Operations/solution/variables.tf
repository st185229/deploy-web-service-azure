variable "tagging_policy_config" {
  type = map(string)
}
variable "tagging_policy_config_assn" {
  type = map(string)
}
variable "prefix" {
  description = "The prefix which should be used for all resources"
  default     = "udacity"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "EastUS"
}