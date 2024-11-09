locals {
  event_roles = toset([
    "roles/artifactregistry.reader",
    "roles/eventarc.eventReceiver"
  ])
}

resource "google_service_account" "event" {
  account_id   = var.functions.event.sa.id
  display_name = "The service account for the notification"

  depends_on = [google_project_service.main]
}

resource "google_project_iam_member" "event" {
  for_each = local.event_roles
  member   = "serviceAccount:${google_service_account.event.email}"

  project = data.google_project.main.project_id
  role    = each.value

  depends_on = [google_project_service.main]
}

resource "google_cloud_run_v2_service_iam_member" "event" {
  project  = google_cloudfunctions2_function.main.project
  location = google_cloudfunctions2_function.main.location

  name   = google_cloudfunctions2_function.main.name
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.event.email}"

  depends_on = [google_project_service.main]
}

resource "google_project_service_identity" "storage" {
  provider = google-beta
  project  = data.google_project.main.project_id
  service  = "storage.googleapis.com"

  depends_on = [google_project_service.main]
}

resource "google_project_iam_member" "gcs" {
  project = data.google_project.main.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-${data.google_project.main.number}@gs-project-accounts.iam.gserviceaccount.com"

  depends_on = [google_project_service.main]
}
