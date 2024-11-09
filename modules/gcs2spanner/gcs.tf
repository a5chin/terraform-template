locals {
  resource_roles = toset([
    "roles/storage.insightsCollectorService",
    "roles/storage.objectUser"
  ])
}

resource "google_storage_bucket" "data" {
  name                        = var.gcs.name
  location                    = var.location
  force_destroy               = false
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = var.gcs.lifecycle_rule.age
    }
    action {
      type = var.gcs.lifecycle_rule.action
    }
  }

  depends_on = [google_project_service.main]
}

resource "google_storage_bucket_iam_member" "gcs" {
  for_each = local.resource_roles
  member   = var.gcs.allows

  bucket = google_storage_bucket.data.name
  role   = each.value

  depends_on = [google_project_service.main]
}
