variable "environment" {
  type        = string
  default     = "Stg"
  description = "Staging target deployment area"
}

variable "dbNames" {
  type    = list(any)
  default = ["VonApp", "GH_PHI"]
}

variable "instance" {
  type        = number
  default     = 0
  description = "The current instance of the item"
}

# variable "default_tags" {
#   type = map(string)
#   default = {
#     "Owner"       = "VON"
#     "environment" = "${var.environment}"
#   }

# }

#Define all the resource groups that we are using and create them
variable "ResourceGroups" {
  description = "List of all the resource groups used in the environment"
  type = list(object({
    resource_group_name = string
    location            = string
    #tags                = list(string)
  }))
  default = [
    { resource_group_name = "DefaultResourceGroup-EUS",
    location = "eastus" },
    { resource_group_name = "GHFunctions",
    location = "eastus" },
    { resource_group_name = "MA_amw-ghmobile_eastus_managed",
    location = "eastus" },
    { resource_group_name = "NetworkWatcherRG",
    location = "eastus" },
    { resource_group_name = "gh-monitor",
    location = "eastus" },
    { resource_group_name = "gh-networking",
    location = "eastus" },
    { resource_group_name = "gh-scaff-private-ressolver",
    location = "eastus" },
    { resource_group_name = "gh-scaffold-dns",
    location = "eastus" },
    { resource_group_name = "gh-scaffold-fhir",
    location = "eastus" },
    { resource_group_name = "gh-scaffold-loadbalancer",
    location = "eastus" },
    { resource_group_name = "gh-scaffold-storage",
    location = "eastus" },
    { resource_group_name = "gh-scaffold-workstations",
    location = "eastus" },
    { resource_group_name = "gh-scaffolding-database"
  location = "eastus" }]
}

