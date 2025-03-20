mock_provider "archive" {}
mock_provider "google" {}

run "schedule" {
  module {
    source = "./"
  }

  variables {
    project_id = "project_id"
    location   = "location"

    scheduler = {
      name     = "name"
      schedule = "* * * * *"
      sa = {
        id = "account-id"
      }
    }

    functions = {
      name   = "name"
      bucket = "bucket"
      sa = {
        id = "account-id"
      }
    }
  }

  command = plan

  assert {
    condition     = google_cloudfunctions2_function.this.service_config[0].max_instance_request_concurrency > 0
    error_message = "`max_instance_request_concurrency` must be greater than 0"
  }
}
