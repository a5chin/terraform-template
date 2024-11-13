output "enabled_apis" {
  description = "Already enabled APIs list."
  value       = [for api in google_project_service.main : api.service]
}

output "policies" {
  description = "Alert policies name object."
  value = {
    error = google_monitoring_alert_policy.main["error"].name
    warn  = google_monitoring_alert_policy.main["warn"].name
  }
}
