resource "google_logging_project_sink" "main" {
  name        = "${var.logging.target}-to-bigquery-sink"
  destination = "bigquery.googleapi.com/${google_bigquery_dataset.main.id}"
  filter      = var.logging.filter

  bigquery_options {
    use_partitioned_tables = true
  }

  unique_writer_identity = true
}

resource "google_project_iam_member" "main" {
  project = data.google_project.main.project_id
  role    = "roles/bigquery.dataEditor"
  member  = google_logging_project_sink.main.writer_identity
}
