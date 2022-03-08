variable "service_account_name" {
    type = string
}
variable "display_name" {
    type = string
    default = null
}
variable "description" {
    type = string
    default = null
}
variable "disabled" {
  type = bool
  default = false
}
variable "roles" {
  type = list(string)
  default = []
  description = "Roles to attach with serviceaccount"
}