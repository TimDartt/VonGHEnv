variable "PublicIPS" {
  description = "A set of Public IP's to create"
  type = list(object(
    { name                = string
      resource_group_name = string
      allocation_method   = string
  }))
  default = [{
    allocation_method   = "Static"
    name                = "gh-fw-mgmt-1"
    resource_group_name = "gh-networking"
    },
    {
      allocation_method   = "Static"
      name                = "gh-fw-publictunnel-1"
      resource_group_name = "gh-networking"
    },
    {
      allocation_method   = "Static"
      name                = "gh-scaffold-gate-public"
      resource_group_name = "gh-networking"
    },
    {
      allocation_method   = "Static"
      name                = "gh-ssms-ip"
      resource_group_name = "gh-scaffold-workstations"
    }

  ]
}
