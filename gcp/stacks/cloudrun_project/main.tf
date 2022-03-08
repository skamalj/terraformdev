terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.88.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  project     = var.project_id
  region      = var.region
}

module "cloudbuild_sa" {
    source = "../../modules/service_account"
    service_account_name = "cloudbuild-for-cloudrun"
    roles = var.roles
}

module "cloudrun_sa" {
    source = "../../modules/service_account"
    service_account_name = "cloudrun-sa"
    roles = ["roles/secretmanager.secretAccessor"]
}

module "customer_repo" {
    source = "../../modules/source_repo"
    source_repo_name = "customer_repo"
}

module "customer_build_trigger" {
    name = "customer-trigger"
    filename = "customer/cloudbuild.yaml"
    source = "../../modules/cloudbuild_trigger"
    repo_name = "customer_repo"
    service_account_id = module.cloudbuild_sa.service_account.id
    depends_on = [
      module.customer_repo
    ]
}

module "demo_app_registry" {
  source = "../../modules/artifact_registry"
  providers = {
    google-beta = google-beta
   }
  repository_id = "demo-app"
  location = var.region
}

module "cloudrun_subnet" {
  source = "../../modules/subnetwork"
  name = "cloudrun"
  ip_cidr_range  =  "10.0.1.0/28"
  network_name = "default"
}

resource "google_vpc_access_connector" "connector" {
  provider = google-beta
  name          = "cloudrun-vpc-con"
  subnet  {
    name = module.cloudrun_subnet.subnet.name
  }
}

module "cloudrun_router" {
  source = "../../modules/cloud_router"
  name = "cloudrun-router"
  network_name = "default"
  asn = "64514"
  advertised_ip_ranges = [{
    range = "10.132.0.0/20"
  }]
}

module "cloudrun_nat" {
  source = "../../modules/cloud_nat"
  name = "cloudrun-nat"
  router_name = module.cloudrun_router.router.name
  nat_ip_allocate_option = "MANUAL_ONLY"
  num_nat_addresses = 1
}
