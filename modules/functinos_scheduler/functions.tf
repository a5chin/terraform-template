locals {
  filename = "00000.zip"
}

resource "google_cloudfunctions2_function" "this" {
  project  = var.project_id
  location = var.location

  name = var.functions.name

  build_config {
    runtime     = var.functions.runtime
    entry_point = var.functions.entry_point
    source {
      storage_source {
        bucket = google_storage_bucket_object.functions.bucket
        object = google_storage_bucket_object.functions.name
      }
    }
  }

  service_config {
    max_instance_count               = var.functions.max_instance_count
    min_instance_count               = var.functions.min_instance_count
    available_memory                 = var.functions.available_memory
    timeout_seconds                  = var.functions.timeout_seconds
    max_instance_request_concurrency = var.functions.max_instance_request_concurrency
    available_cpu                    = var.functions.available_cpu
    environment_variables            = var.functions.environment_variables
    ingress_settings                 = "ALLOW_INTERNAL_ONLY"
    service_account_email            = google_service_account.functions.email
  }

  lifecycle {
    ignore_changes = [
      build_config[0].docker_repository,
    ]
  }

  depends_on = [
    google_project_service.this,
  ]
}

resource "google_storage_bucket" "functions" {
  project  = var.project_id
  location = var.location

  name                        = var.functions.bucket
  force_destroy               = false
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  depends_on = [google_project_service.this]
}

data "archive_file" "functions" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "tmp/${local.filename}"
}

resource "google_storage_bucket_object" "functions" {
  name   = "functions-scheduler/${local.filename}"
  source = data.archive_file.functions.output_path
  bucket = var.functions.bucket

  depends_on = [google_project_service.this]
}

resource "google_service_account" "functions" {
  account_id   = var.functions.sa.id
  display_name = "The service account for the Cloud Functions"

  depends_on = [google_project_service.this]
}

resource "google_project_iam_member" "functions" {
  for_each = var.functions.sa.roles
  member   = "serviceAccount:${google_service_account.functions.email}"

  project = var.project_id
  role    = each.value

  depends_on = [google_project_service.this]
}
