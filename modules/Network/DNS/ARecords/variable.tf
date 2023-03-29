variable "ARecords" {
  description = "A list of the A records"
  type = list(object(
    {
      name                = string
      zone_name           = string
      resource_group_name = string
      ttl                 = number
      records             = list(string)

    }
  ))

}
