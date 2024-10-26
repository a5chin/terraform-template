locals {
  environment_variables = {
    PROJECT_ID            = data.google_project.main.project_id
    REGION                = var.location
    JOB_NAME              = var.dataflow.name
    GCS_PATH              = var.dataflow.gcsPath
    INSTANCE_ID           = var.dataflow.parameters.instanceId
    DATABACE_ID           = var.dataflow.parameters.databaseId
    INPUT_DIR             = "gs://${var.dataflow.parameters.inputDir}"
    SERVICE_ACCOUNT_EMAIL = google_service_account.dataflow.email
    TEMP_LOCATION         = "gs://${var.dataflow.temp_gcs_location}"
    SUBNETWORK            = google_compute_subnetwork.dataflow.self_link
  }
}
