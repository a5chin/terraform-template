resource "google_storage_bucket" "data" {
  name                        = var.dataflow.parameters.inputDir
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

resource "google_storage_bucket" "functions" {
  name                        = var.functions.bucket
  location                    = var.location
  force_destroy               = false
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  depends_on = [google_project_service.main]
}
