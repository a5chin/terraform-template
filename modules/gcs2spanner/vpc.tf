resource "google_compute_network" "dataflow" {
  project = data.google_project.this.project_id

  name                    = var.vpc.network.name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "dataflow" {
  project = data.google_project.this.project_id
  region  = var.location

  name                       = var.vpc.subnetwork.name
  ip_cidr_range              = var.vpc.subnetwork.ip_cidr_range
  network                    = google_compute_network.dataflow.self_link
  purpose                    = "PRIVATE"
  stack_type                 = "IPV4_ONLY"
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
}
