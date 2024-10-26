locals {
  apis = toset([
    "cloudbuild.googleapis.com",
    "cloudfunctions.googleapis.com",
    "dataflow.googleapis.com",
    "eventarc.googleapis.com",
    "iam.googleapis.com",
    "pubsub.googleapis.com",
    "storage.googleapis.com",
  ])
}

data "google_project" "main" {}

resource "google_project_service" "main" {
  for_each = local.apis

  project            = data.google_project.main.project_id
  service            = each.value
  disable_on_destroy = false
}
