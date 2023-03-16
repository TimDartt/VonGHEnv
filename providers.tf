# Configure the Azure providers used by these scripts
## this is general boilplate that is needed for terraform

# set up the initial definition of the space & prepare it to used with terraform cloud
terraform {
  cloud {
    organization = "TdarttVonTest"
    workspaces {
      name = "VonGHEnv"
    }
  }
}

# the following sets the default providers used in the main.tf file for this directory
terraform {
  required_version = ">= 1.1.0"
  required_providers {
    #
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
    # the random provider allows for the creation of random strings
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }

}

# Configure the Microsoft Azure Provider
# azurerm always needs the features space...a
provider "azurerm" {
  features {}
}

