mock_provider "google" {}

override_data {
  target = data.google_service_account.this
  values = {
    id = "projects/project-id/serviceAccounts/sample@project-id.iam.gserviceaccount.com"
  }
}

run "no_provider_id" {
  module {
    source = "./"
  }

  variables {
    project_id     = "project_id"
    project_number = "0123456789"

    pool = {
      id = "pool-id"
    }
    pool_provider = {
      attribute_condition = <<EOT
        assertion.repository_owner == "a5chin"
      EOT
      attribute_claims    = ["repository"]
      issuer_uri          = "https://token.actions.githubusercontent.com"
    }
    principals = [
      {
        service_account = "sample@project-id.iam.gserviceaccount.com"
        attribute = {
          name  = "repository"
          value = "sample-repo"
        }
      }
    ]
  }

  command = plan

  assert {
    condition     = google_iam_workload_identity_pool_provider.this.workload_identity_pool_id == "pool-id"
    error_message = "`workload_identity_pool_id` is invalid"
  }
  assert {
    condition     = google_iam_workload_identity_pool_provider.this.workload_identity_pool_provider_id == "pool-id"
    error_message = "`workload_identity_pool_provider_id` is invalid"
  }
}

run "valid_id" {
  module {
    source = "./"
  }

  variables {
    project_id     = "project_id"
    project_number = "0123456789"

    pool = {
      id = "pool-id"
    }
    pool_provider = {
      id                  = "provider-id"
      attribute_condition = <<EOT
        assertion.repository_owner == "a5chin"
      EOT
      attribute_claims    = ["repository"]
      issuer_uri          = "https://token.actions.githubusercontent.com"
    }
    principals = [
      {
        service_account = "sample@project-id.iam.gserviceaccount.com"
        attribute = {
          name  = "repository"
          value = "sample-repo"
        }
      }
    ]
  }

  command = plan

  assert {
    condition     = google_iam_workload_identity_pool_provider.this.workload_identity_pool_id == "pool-id"
    error_message = "`workload_identity_pool_id` is invalid"
  }
  assert {
    condition     = google_iam_workload_identity_pool_provider.this.workload_identity_pool_provider_id == "provider-id"
    error_message = "`workload_identity_pool_provider_id` is invalid"
  }
}
