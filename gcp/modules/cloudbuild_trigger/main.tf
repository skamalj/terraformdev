terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">= 3.88.0"
    }
  }
}

data "google_project" "project" {
}

resource "google_cloudbuild_trigger" "cloudbuild_trigger" {
    name = var.name 
    description = var.description 
    service_account = var.service_account_id 

    trigger_template {
      tag_name = var.tag_name
      repo_name   = var.repo_name
    }

    substitutions = var.substitutions

    filename = var.filename
}