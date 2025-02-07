resource "google_compute_network" "this" {
  name                    = var.backend.name
  auto_create_subnetworks = false
}

resource "google_compute_global_address" "this" {
  name          = var.backend.name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = "10.20.0.0"
  prefix_length = 16
  network       = google_compute_network.this.self_link
}

resource "google_service_networking_connection" "this" {
  network = google_compute_network.this.self_link
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.this.name
  ]
}

resource "google_vpc_access_connector" "this" {
  provider      = google-beta
  name          = var.backend.name
  region        = var.location
  ip_cidr_range = "10.30.0.0/28"
  network       = google_compute_network.this.name
  machine_type  = "e2-micro"
}
