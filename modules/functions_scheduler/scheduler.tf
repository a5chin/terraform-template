resource "google_cloud_scheduler_job" "this" {
  name   = var.scheduler.name
  region = var.location

  time_zone = var.scheduler.time_zone
  schedule  = var.scheduler.schedule

  http_target {
    http_method = "POST"
    uri         = google_cloudfunctions2_function.this.url
    body        = base64encode(jsonencode(var.scheduler.body))

    oidc_token {
      service_account_email = google_service_account.scheduler.email
      audience              = google_cloudfunctions2_function.this.url
    }
  }
}

resource "google_service_account" "scheduler" {
  account_id = var.scheduler.sa.id
}

resource "google_cloud_run_service_iam_member" "scheduler" {
  service  = google_cloudfunctions2_function.this.name
  location = var.location
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.scheduler.email}"
}
