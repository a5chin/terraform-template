locals {
  dataflow_roles = toset([
    "roles/dataflow.worker",
    "roles/monitoring.metricWriter",
    "roles/spanner.databaseUser",
    "roles/storage.objectUser"
  ])
  functions_roles = toset([
    "roles/iam.serviceAccountUser",
    "roles/dataflow.developer"
  ])
  event_roles = toset([
    "roles/artifactregistry.reader",
    "roles/eventarc.eventReceiver"
  ])
  resource_roles = toset([
    "roles/storage.insightsCollectorService",
    "roles/storage.objectUser"
  ])
}

resource "google_service_account" "dataflow" {
  account_id   = var.dataflow.sa.id
  display_name = "The service account for the Dataflow"

  depends_on = [google_project_service.main]
}

resource "google_project_iam_member" "dataflow" {
  for_each = local.dataflow_roles
  member   = "serviceAccount:${google_service_account.dataflow.email}"

  project = data.google_project.main.project_id
  role    = each.value

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

resource "google_project_iam_member" "storage" {
  project = data.google_project.main.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-${data.google_project.main.number}@gs-project-accounts.iam.gserviceaccount.com"

  depends_on = [google_project_service.main]
}

resource "google_storage_bucket_iam_member" "resource" {
  for_each = local.resource_roles
  member   = "serviceAccount:${var.resource.sa.email}"

  bucket = google_storage_bucket.data.name
  role   = each.value

  depends_on = [google_project_service.main]
}
