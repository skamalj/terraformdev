variable "location" {
    type = string
}
variable "repository_id" {
    type = string
}
variable "kms_key_name" {
    type = string
    default = null 
}
variable "description" {
    type = string
    default = null
}
variable "format" {
    type = string
    default = "DOCKER"
  
}