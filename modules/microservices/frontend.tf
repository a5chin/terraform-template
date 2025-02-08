locals {
  frontend = {
    BASE_URL = google_cloud_run_v2_service.backend.uri
  }
}

resource "google_cloud_run_v2_service" "frontend" {
  name     = var.frontend.name
  location = var.location

  template {
    scaling {
      max_instance_count = var.frontend.max_instance_count
      min_instance_count = var.frontend.min_instance_count
    }

    service_account = google_service_account.frontend_executor.email

    containers {
      image = var.frontend.image

      startup_probe {
        initial_delay_seconds = 10
        timeout_seconds       = 240
        period_seconds        = 240
        failure_threshold     = 3

        http_get {
          path = "/api/v1/healthz"
          port = 8080
        }
      }

      liveness_probe {
        initial_delay_seconds = 10
        timeout_seconds       = 120
        period_seconds        = 120
        failure_threshold     = 3

        http_get {
          path = "/api/v1/healthz"
          port = 8080
        }
      }

      resources {
        cpu_idle = true
        limits = {
          cpu    = var.frontend.cpu
          memory = var.frontend.memory
        }
      }

      dynamic "env" {
        for_each = local.frontend
        content {
          name  = env.key
          value = env.value
        }
      }
    }
  }

  depends_on = [
    google_project_service.this,
  ]
}

resource "google_service_account" "frontend_executor" {
  project      = var.project_id
  account_id   = var.frontend.executor.id
  display_name = "The Service Account for Frontend executor"
}

resource "google_project_iam_member" "frontend_executor" {
  for_each = var.frontend.executor.roles
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.frontend_executor.email}"
}

resource "google_cloud_run_v2_service_iam_member" "frontend_invoker" {
  project  = google_cloud_run_v2_service.frontend.project
  location = google_cloud_run_v2_service.frontend.location
  name     = google_cloud_run_v2_service.frontend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
