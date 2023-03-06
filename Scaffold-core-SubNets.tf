variable "Scaffold-Core-SubNets" {
  type = list(object({
    name           = string
    address_prefix = string
  }))
  description = "All the subnets for Scaffold-core and their address prefixs"
  default = [{
    name           = "core-routing"
    address_prefix = "${var.BaseNet}50.0/24"
    }
    , {
      name           = "AzureFirewall,"
      address_prefix = "${var.BaseNet}100.0/24"
    }
    , {
      name           = "AzureFirewallManagement,"
      address_prefix = "${var.BaseNet}90.0/24"
    }
    , {
      name           = "gh-private-1"
      address_prefix = "${var.BaseNet}70.0/24"
    }
    , {
      name           = "Gateway,"
      address_prefix = "${var.BaseNet}0.0/24"
    }
    , {
      name           = "GH-Scaffold-VM"
      address_prefix = "${var.BaseNet}95.0/24"
    }
    , {
      name           = "gh-scaffold-lb-priv-backendservers"
      address_prefix = "${var.BaseNet}10.0/24"
    }
    , {
      name           = "gh-scaffold-lb-priv-standard-internal"
      address_prefix = "${var.BaseNet}11.0/24"
    }
    , {
      name           = "gh-scaffold-lb-priv-private-linkservice"
      address_prefix = "${var.BaseNet}12.0/24"
    }
    , {
      name           = "gh-scaff-asg-frontend"
      address_prefix = "${var.BaseNet}20.0/24"
    }
    , {
      name           = "gh-scaff-asg-controlplane"
      address_prefix = "${var.BaseNet}21.0/24"
    }
    , {
      name           = "gh-scaff-asg-backend"
      address_prefix = "${var.BaseNet}22.0/24"
    }
    , {
      name           = "gh-scaff-asg-connector"
      address_prefix = "${var.BaseNet}23.0/24"
    }
    , {
      name           = "gh-public-1"
      address_prefix = "${var.BaseNet}60.0/24"
    }
    , {
      name           = "gh-scaffold-private-dns-,"
      address_prefix = "${var.BaseNet}96.0/24"
    }
    , {
      name           = "gh-scaffold-dns-internal"
      address_prefix = "${var.BaseNet}45.0/24"
    }
    , {
      name           = "gh-scaffold-dns-outbound"
      address_prefix = "${var.BaseNet}46.0/24"
    }
    , {
      name           = "gh-internal-1"
      address_prefix = "${var.BaseNet}80.0/24"
    }
  ]
}
