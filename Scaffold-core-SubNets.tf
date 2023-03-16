locals {
  Scaffold-Core-SubNets = {
    //description = "All the subnets for Scaffold-core and their address prefixs"
    //    subnets = {
    sn1 = {
      name           = "core-routing"
      address_prefix = "50.0/24"
      nsg            = local.nsg-gh-scaffold-mssql-Rules
    },
    sn2 = {
      name           = "AzureFirewall"
      address_prefix = "100.0/24"
      nsg            = {}
    },
    sn3 = {
      name           = "AzureFirewallManagement"
      address_prefix = "90.0/24"
      nsg            = {}
    },
    sn4 = {
      name           = "gh-private-1"
      address_prefix = "70.0/24"
      nsg            = {}
    },
    sn5 = {
      name           = "Gateway"
      address_prefix = "0.0/24"
      nsg            = {}
    },
    sn6 = {
      name           = "GH-Scaffold-VM"
      address_prefix = "95.0/24"
      nsg            = {}
    },
    sn7 = {
      name           = "gh-scaffold-lb-priv-backendservers"
      address_prefix = "10.0/24"
      nsg            = {}
    },
    sn8 = {
      name           = "gh-scaffold-lb-priv-standard-internal"
      address_prefix = "11.0/24"
      nsg            = {}
    },
    sn9 = {
      name           = "gh-scaffold-lb-priv-private-linkservice"
      address_prefix = "12.0/24"
      nsg            = {}
    },
    sn10 = {
      name           = "gh-scaff-asg-frontend"
      address_prefix = "20.0/24"
      nsg            = {}
    },
    sn11 = {
      name           = "gh-scaff-asg-controlplane"
      address_prefix = "21.0/24"
      nsg            = {}
    },
    sn12 = {
      name           = "gh-scaff-asg-backend"
      address_prefix = "22.0/24"
      nsg            = {}
    },
    sn13 = {
      name           = "gh-scaff-asg-connector"
      address_prefix = "23.0/24"
      nsg            = {}
    },
    sn14 = {
      name           = "gh-public-1"
      address_prefix = "60.0/24"
      nsg            = {}
    },
    sn15 = {
      name           = "gh-scaffold-private-dns"
      address_prefix = "96.0/24"
      nsg            = {}
    },
    sn16 = {
      name           = "gh-scaffold-dns-internal"
      address_prefix = "45.0/24"
      nsg            = {}
    },
    sn17 = {
      name           = "gh-scaffold-dns-outbound"
      address_prefix = "46.0/24"
      nsg            = {}
    },
    sn18 = {
      name           = "gh-internal-1"
      address_prefix = "80.0/24"
      nsg            = {}
    }
  }
  //  }
}
