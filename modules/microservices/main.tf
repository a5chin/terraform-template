locals {
  apis = toset([
    "cloudbuild.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "run.googleapis.com",
    "servicenetworking.googleapis.com",
    "vpcaccess.googleapis.com",
  ])
}

resource "google_project_service" "this" {
  for_each = local.apis

  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}
