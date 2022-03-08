variable "source_repo_name" {
  type = string
}
variable "topic_list" {
  type = list(string)
  default = []
}
variable "message_format" {
  type = string
  default = "JSON"
}
variable "service_account_email" {
  type = string
  default = null
}