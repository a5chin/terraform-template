locals {
  gcs_roles = toset([
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

resource "google_storage_bucket_iam_member" "data" {
  for_each = {
    for v in setproduct(var.gcs.allows, local.gcs_roles) : join(":", v) => v
  }
  member = each.value[0]
  role   = each.value[1]

  bucket = google_storage_bucket.data.name

  depends_on = [google_project_service.main]
}
