variable "name" {
    type = string
}
variable "ip_cidr_range" {
    type = string
}
variable "region" {
    type = string
    default = null
}
variable "network_name" {
  type = string
}
variable "description" {
  type = string
  default = null
}
variable "role" {
    type = string
    default = null
}
variable "secondary_ranges" {
    type = list(object({
        range_name = string
        ip_cidr_range = string
    }))
    default = []
}
variable "aggregation_interval" {
    type = string
    default = null
}
variable "flow_sampling" {
  type = number
  default = null
}
variable "metadata" {
  type = string
  default = null 
}

variable "private_ip_google_access" {
  type = bool
  default = true
}
