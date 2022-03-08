terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.88.0"
    }
  }
}

data "google_compute_subnetwork" "subnetwork_to_nat" {
    for_each = var.subnetworks
    name   = each.key
}

resource "google_compute_address" "nat_address" {
    count = var.num_nat_addresses
    name = join("-",[var.name,"addr",count.index])
}
resource "google_compute_router_nat" "cloud_nat" {
  name   = var.name
  nat_ip_allocate_option = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat

  router = var.router_name
  nat_ips = var.nat_ip_allocate_option == "MANUAL_ONLY" ? google_compute_address.nat_address[*].id : null

  dynamic "subnetwork" {
      for_each = (var.source_subnetwork_ip_ranges_to_nat == 
                    "LIST_OF_SUBNETWORKS" ? var.subnetworks : {})
        content {
            name                    = data.google_compute_subnetwork.subnetwork_to_nat[subnetwork.key].id
            source_ip_ranges_to_nat = subnetwork.value.source_ip_ranges_to_nat
            secondary_ip_range_names = (contains(subnetwork.value.source_ip_ranges_to_nat,
                                        "LIST_OF_SECONDARY_IP_RANGES") ? subnetwork.value.secondary_ip_range_names : null)       
        }
  }
  depends_on = [
    google_compute_address.nat_address
  ]
}