terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">= 3.88.0"
    }
  }
}

data "google_compute_network" "network" {
    name = var.network_name
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = data.google_compute_network.network.id
  description   = var.description
  role          = var.role
  private_ip_google_access = var.private_ip_google_access
  dynamic "secondary_ip_range" {
    for_each = var.secondary_ranges
    content {
        range_name    = secondary_ip_range.range_name
        ip_cidr_range = secondary_ip_range.ip_cidr_range
    }
  }
  dynamic "log_config" {
    for_each = (var.aggregation_interval != null  || 
                    var.flow_sampling != null || 
                    var.metadata != null)  ? [1] : []
    content {
      aggregation_interval = var.aggregation_interval
      flow_sampling = var.flow_sampling
      metadata =  var.metadata
    }
  }
}