output "enabled_apis" {
  description = "Already enabled APIs list."
  value       = [for api in google_project_service.main : api.service]
}

output "dataflow" {
  description = "Configs of Dataflow"
  value = {
    name = var.dataflow.name
  }
}

output "functions" {
  description = "Configs of Cloud Functions"
  value = {
    name   = var.functions.name
    memory = var.functions.available_memory
  }
}
