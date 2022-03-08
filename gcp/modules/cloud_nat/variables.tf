variable "name" {
  type = string 
}
variable "nat_ip_allocate_option" {
  type = string
  default = "AUTO_ONLY"
}
variable "source_subnetwork_ip_ranges_to_nat" {
  type = string 
  default = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  description = "Other values are ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES or LIST_OF_SUBNETWORKS"
}
variable "router_name" {
  type= string 
}
variable "num_nat_addresses" {
    type = number
    default = 0
}
/*
{
    "subnet-name" = {
        source_ip_ranges_to_nat = string
        secondary_ip_range_names = list(string)
    }
    ...
}
*/
variable "subnetworks" {
    type = map 
    default = {}
}