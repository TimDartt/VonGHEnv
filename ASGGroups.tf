# The following list is a set of all the application security groups to be built
variable "ASGGroups" {
  type = list(object({
    ASGName       = string
    ResourceGroup = string
    tags          = map(string)
  }))
  default = [
    {
      ASGName       = "asg-scaffold-mssql",
      ResourceGroup = "gh-networking",
      tags          = { test : "asg" }

    },
    {
      ASGName       = "gh-scaffold-df",
      ResourceGroup = "gh-networking",
      tags          = { test : "asg" }
    },
    {
      ASGName       = "gh-scaffold-functapp-asg",
      ResourceGroup = "gh-networking",
      tags          = { test : "asg" }
    },
    {
      ASGName       = "scaffold-fhir-asg",
      ResourceGroup = "gh-scaffold-fhir",
      tags          = { test : "asg" }
    },
    {
      ASGName       = "scaffold-storage-asg",
      ResourceGroup = "gh-scaffold-storage",
      tags          = { test : "asg" }
    }
  ]
}
