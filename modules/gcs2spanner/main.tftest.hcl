mock_provider "archive" {}
mock_provider "google" {}
mock_provider "google-beta" {}

run "valid_roles" {
  module {
    source = "./"
  }

  variables {
    project_id = "project_id"
    location   = "location"

    dataflow = {
      name              = "name"
      temp_gcs_location = "temp_gcs_location"
      parameters = {
        instanceId = "instanceId"
        databaseId = "databaseId"
        subnetwork = "subnetwork"
      }
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
      event = {
        sa = {
          id = "account-id"
        }
      }
    }

    gcs = {
      name = "name"
      allows = [
        "serviceAccount:mail", "group:adress"
      ]
    }

    vpc = {
      network = {
        name = "name"
      }
      subnetwork = {
        name          = "name"
        ip_cidr_range = "0.0.0.0/0"
      }
    }
  }

  command = plan

  assert {
    condition     = length(google_storage_bucket_iam_member.data) == 4
    error_message = "Service accounts is not properly tied to roles"
  }
}
