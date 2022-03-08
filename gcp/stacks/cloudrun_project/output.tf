output "source_repo_url" {
  value = module.customer_repo.source_repo.url
}

output "demo_app_registry_id" {
  value = module.demo_app_registry.artifact_registry.id
}

/*
output "nat" {
  value = module.cloudrun_nat.nat
}

output "vpc_access" {
  value = google_vpc_access_connector.connector
}
*/
