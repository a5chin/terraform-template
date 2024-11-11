resource "google_compute_network" "main" {
  name                    = var.backend.name
  auto_create_subnetworks = false
}

resource "google_compute_global_address" "main" {
  name          = var.backend.name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = "10.20.0.0"
  prefix_length = 16
  network       = google_compute_network.main.self_link
}

resource "google_service_networking_connection" "main" {
  network = google_compute_network.main.self_link
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.main.name
  ]
}

resource "google_vpc_access_connector" "main" {
  provider      = google-beta
  name          = var.backend.name
  region        = var.location
  ip_cidr_range = "10.30.0.0/28"
  network       = google_compute_network.main.name
  machine_type  = "e2-micro"
}
