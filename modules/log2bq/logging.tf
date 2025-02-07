resource "google_logging_project_sink" "this" {
  name        = "${var.logging.target}-to-bigquery-sink"
  destination = "bigquery.googleapi.com/${google_bigquery_dataset.this.id}"
  filter      = var.logging.filter

  bigquery_options {
    use_partitioned_tables = true
  }

  unique_writer_identity = true
}

resource "google_project_iam_member" "this" {
  project = var.project_id
  role    = "roles/bigquery.dataEditor"
  member  = google_logging_project_sink.this.writer_identity
}
