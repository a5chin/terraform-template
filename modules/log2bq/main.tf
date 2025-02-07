locals {
  apis = toset([
    "bigquery.googleapis.com",
    "logging.googleapis.com",
  ])
}

resource "google_project_service" "this" {
  for_each = local.apis

  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}
