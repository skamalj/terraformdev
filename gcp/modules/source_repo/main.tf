terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">= 3.88.0"
    }
  }
}

resource "google_sourcerepo_repository" "source_repo" {
  name = var.source_repo_name
  dynamic "pubsub_configs" {
      for_each = toset(var.topic_list)
      content {
          topic = pubsub_configs.value
          message_format = var.message_format
          service_account_email = var.service_account_email
      }
  }
}
