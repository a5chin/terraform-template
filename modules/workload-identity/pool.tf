resource "google_iam_workload_identity_pool" "this" {
  project = var.project_id

  description               = var.pool.description
  workload_identity_pool_id = var.pool.id
  display_name              = coalesce(var.pool.display_name, var.pool.id)
}
