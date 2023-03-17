variable "environment" {
  type        = string
  default     = "Dev"
  description = "Dev target deployment area"
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
    tags                = map(string)
  }))
  default = [
    { resource_group_name = "DefaultResourceGroup-EUS",
      tags = {
        source = "terraform"
      },
    location = "eastus" },
    { resource_group_name = "GHFunctions",
      tags = {
        source = "terraform"
      },
    location = "eastus" },
    { resource_group_name = "MA_amw-ghmobile_eastus_managed",
      tags = {
        source = "terraform"
      },
    location = "eastus" },
    { resource_group_name = "NetworkWatcherRG",
      tags = {
        source = "terraform"
      },
    location = "eastus" },
    { resource_group_name = "gh-monitor",
      tags = {
        source = "terraform"
      },
    location = "eastus" },
    { resource_group_name = "gh-scaff-private-ressolver",
      tags = {
        source = "terraform"
      },
    location = "eastus" },
    { resource_group_name = "gh-scaffold-dns",
      tags = {
        source = "terraform"
      },
    location = "eastus" },
    { resource_group_name = "gh-scaffold-fhir",
      tags = {
        source = "terraform"
      },
    location = "eastus" },
    { resource_group_name = "gh-scaffold-loadbalancer",
      tags = {
        source = "terraform"
      },
    location = "eastus" },
    { resource_group_name = "gh-scaffold-storage",
      tags = {
        source = "terraform"
      },
    location = "eastus" },
    { resource_group_name = "gh-scaffold-workstations",
      tags = {
        source = "terraform"
      },
    location = "eastus" },
    { resource_group_name = "gh-scaffolding-database"
      tags = {
        source = "terraform"
      },
    location = "eastus" }
    , { resource_group_name = "gh-networking"
      tags = {
        source = "terraform"
      },
    location = "eastus" }
  ]
}

variable "BaseNet" {
  type        = string
  description = "The base network address for the environment"
}
variable "Env" {
  type        = string
  description = "The environment being built"

}
