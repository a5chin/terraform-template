output "enabled_apis" {
  description = "Already enabled APIs list."
  value       = [for api in google_project_service.main : api.service]
}

output "policies" {
  description = "Alert policies name map."
  value = {
    for k in keys(var.target.alert) : k => google_monitoring_alert_policy.main[k].name
  }
}
