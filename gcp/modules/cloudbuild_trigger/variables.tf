variable "name" {
  type = string
  default = null
}
variable "description" {
  type = string
  default = null
}
variable "service_account_id" {
  type = string
  default = null
}
variable "filename" {
  type = string
  default = "cloudbuild.yaml"
}
variable "branch_name" {
  type = string
  default = "master"
}
variable "repo_name" {
  type = string
}
variable "substitutions" {
  type = map
  default = null
}