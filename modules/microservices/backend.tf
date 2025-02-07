resource "google_cloud_run_v2_service" "backend" {
  name     = var.backend.name
  location = var.location

  template {
    scaling {
      max_instance_count = var.backend.max_instance_count
      min_instance_count = var.backend.min_instance_count
    }

    vpc_access {
      connector = google_vpc_access_connector.this.id
      egress    = "PRIVATE_RANGES_ONLY"
    }

    service_account = google_service_account.backend_executor.email

    containers {
      image = var.backend.image

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
        timeout_seconds       = 60
        period_seconds        = 60
        failure_threshold     = 3

        http_get {
          path = "/api/v1/healthz"
          port = 8080
        }
      }

      resources {
        cpu_idle = true
        limits = {
          cpu    = var.backend.cpu
          memory = var.backend.memory
        }
      }

      dynamic "env" {
        for_each = var.backend.env
        content {
          name  = env.key
          value = env.value
        }
      }
    }
  }

  depends_on = [
    google_project_service.this,
    google_sql_user.this,
  ]
}

resource "google_service_account" "backend_executor" {
  project      = var.project_id
  account_id   = var.backend.executor.id
  display_name = "The Service Account for Backend executor"
}

resource "google_project_iam_member" "backend_executor" {
  for_each = var.backend.executor.roles
  role     = each.value

  project = var.project_id
  member  = "serviceAccount:${google_service_account.backend_executor.email}"
}

resource "google_service_account" "backend_invoker" {
  for_each   = var.backend.invoker.ids
  account_id = each.value

  project      = var.project_id
  display_name = "The Service Account for Backend invoker"
}

resource "google_cloud_run_v2_service_iam_member" "backend_invoker" {
  for_each = setunion(
    [google_service_account.frontend_executor.email],
    [for invoker in google_service_account.backend_invoker : invoker.email],
    var.backend.invoker.emails,
  )
  member = "serviceAccount:${each.value}"

  project  = google_cloud_run_v2_service.backend.project
  location = google_cloud_run_v2_service.backend.location
  name     = google_cloud_run_v2_service.backend.name
  role     = "roles/run.invoker"
}
