locals {
  apis = toset([
    "cloudfunctions.googleapis.com",
    "cloudscheduler.googleapis.com",
    "iam.googleapis.com",
  ])
}

resource "google_project_service" "this" {
  for_each = local.apis

  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}
