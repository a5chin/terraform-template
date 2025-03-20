output "enabled_apis" {
  description = "Already enabled APIs list"
  value       = [for api in google_project_service.this : api.service]
}
