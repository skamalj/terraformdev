terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.88.0"
    }
  }
}

resource "google_compute_router" "router" {
  name    = var.name
  network = var.network_name
  dynamic "bgp" {
      for_each = try(var.asn,null) != null ? [1] : []
      content {
        asn               = var.asn
        advertise_mode    = var.advertise_mode
        advertised_groups = var.advertise_mode == "CUSTOM" ? var.advertised_groups : null
        dynamic "advertised_ip_ranges" {
            for_each = var.advertise_mode == "CUSTOM" ? var.advertised_ip_ranges : []
            content {
                range = advertised_ip_ranges.value.range
                description = try(advertised_ip_ranges.value.description,null)
            }
        }
      }
  }
}
