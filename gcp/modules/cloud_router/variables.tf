variable "name" {
  type = string
}
variable "network_name" {
  type = string
}
variable "asn" {
  type = string
  default = null
}
variable "advertise_mode" {
  type = string
  default = "DEFAULT" 
  description = "DEFAULT or CUSTOM"
}
variable "advertised_groups" {
  type = list(string) 
  default = ["ALL_SUBNETS"]
}
variable "advertised_ip_ranges" {
  type = list(object({
      range = string
      description = optional(string)
  }))
  default = []
}