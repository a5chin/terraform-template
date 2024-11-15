resource "google_bigquery_dataset" "main" {
  dataset_id                      = "cloud_logging_sinked_${var.logging.target}"
  description                     = "Cloud Logging sinked dataset"
  location                        = "US"
  default_partition_expiration_ms = 60 * 1000 * 24 * var.bigquery.expiration_days
  storage_billing_model           = "PHYSICAL"
}

resource "google_bigquery_table" "main" {
  dataset_id = google_bigquery_dataset.main.dataset_id
  table_id   = var.bigquery.view

  view {
    query          = <<EOF
      SELECT *
      FROM `${google_bigquery_dataset.main.dataset_id}.${var.bigquery.table}`
      WEHRE ${var.logging.target}
    EOF
    use_legacy_sql = false
  }

  require_partition_filter = false
}
