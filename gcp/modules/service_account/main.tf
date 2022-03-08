terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">= 3.88.0"
    }
  }
}

resource "google_service_account" "service_account" {
  account_id = var.service_account_name
  display_name = var.display_name
  description = var.description
  disabled = var.disabled
}

resource "google_project_iam_member" "attach_role" {
    for_each = toset(var.roles)
    role    = each.value
    member  = "serviceAccount:${google_service_account.service_account.email}"
}