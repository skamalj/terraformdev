output "nat" {
  value = {id = google_compute_router_nat.cloud_nat.id, 
            ips = google_compute_router_nat.cloud_nat.nat_ips}
  description = "Cloud NAT id and ip object"
}