output "enabled_apis" {
  description = "Already enabled APIs list"
  value       = [for api in google_project_service.this : api.service]
}

output "workload_identity_pools" {
  description = "The ID Workload Identity Pools"
  value       = google_iam_workload_identity_pool_provider.this.id
}
