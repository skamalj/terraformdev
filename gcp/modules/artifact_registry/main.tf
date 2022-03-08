terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
      version = "3.88.0"
    }
  }
}

resource "google_artifact_registry_repository" "artifact_registry" {
  provider = google-beta

  location = var.location
  repository_id = var.repository_id
  description = var.description
  format = var.format
  kms_key_name = var.kms_key_name
}