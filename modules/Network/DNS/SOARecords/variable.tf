variable "SOARecords" {
  description = "A list of the SOARecords for the env"
  type = list(object(
    {
      zone_name           = string
      resource_group_name = string
    }
  ))
}
