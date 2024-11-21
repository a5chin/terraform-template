locals {
  environment_variables = {
    PROJECT_ID            = data.google_project.main.project_id
    REGION                = var.location
    JOB_NAME              = var.dataflow.name
    GCS_PATH              = var.dataflow.gcsPath
    INSTANCE_ID           = var.dataflow.parameters.instanceId
    DATABACE_ID           = var.dataflow.parameters.databaseId
    INPUT_DIR             = "gs://${var.gcs.name}"
    SERVICE_ACCOUNT_EMAIL = google_service_account.dataflow.email
    TEMP_LOCATION         = "gs://${var.dataflow.temp_gcs_location}"
    SUBNETWORK            = google_compute_subnetwork.dataflow.self_link
  }
  dataflow_roles = toset([
    "roles/dataflow.worker",
    "roles/monitoring.metricWriter",
    "roles/spanner.databaseUser",
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

  project = var.project_id
  role    = each.value

  depends_on = [google_project_service.main]
}
