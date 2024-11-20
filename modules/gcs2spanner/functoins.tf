locals {
  filename = "00000.zip"
  functions_roles = toset([
    "roles/iam.serviceAccountUser",
    "roles/dataflow.developer"
  ])
}

resource "google_cloudfunctions2_function" "main" {
  project  = var.project_id
  location = var.location

  name = var.functions.name

  build_config {
    runtime     = "python310"
    entry_point = "create"
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
    environment_variables            = local.environment_variables
    ingress_settings                 = "ALLOW_INTERNAL_ONLY"
    service_account_email            = google_service_account.functions.email
  }

  event_trigger {
    trigger_region        = var.location
    event_type            = "google.cloud.storage.object.v1.finalized"
    retry_policy          = "RETRY_POLICY_RETRY"
    service_account_email = google_service_account.event.email

    event_filters {
      attribute = "bucket"
      value     = google_storage_bucket.data.name
    }
  }

  lifecycle {
    ignore_changes = [
      build_config[0].docker_repository,
      service_config[0].environment_variables["LOG_EXECUTION_ID"]
    ]
  }

  depends_on = [
    google_project_iam_member.event,
    google_project_service.main,
  ]
}

resource "google_storage_bucket" "functions" {
  project  = var.project_id
  location = var.location

  name                        = var.functions.bucket
  force_destroy               = false
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  depends_on = [google_project_service.main]
}

data "archive_file" "functions" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "tmp/${local.filename}"
}

resource "google_storage_bucket_object" "functions" {
  name   = "gcs2spanner/${local.filename}"
  source = data.archive_file.functions.output_path
  bucket = var.functions.bucket

  depends_on = [google_project_service.main]
}

resource "google_service_account" "functions" {
  account_id   = var.functions.sa.id
  display_name = "The service account for the Cloud Functions"

  depends_on = [google_project_service.main]
}

resource "google_project_iam_member" "functions" {
  for_each = local.functions_roles
  member   = "serviceAccount:${google_service_account.functions.email}"

  project = data.google_project.main.project_id
  role    = each.value

  depends_on = [google_project_service.main]
}
