mock_provider "google" {}

run "valid_threshold" {
  module {
    source = "./"
  }

  variables {
    project_id = "project_id"

    target = {
      title         = "Title"
      metric        = "xxx.googleapis.com/xxx/xxx"
      resource_type = "xxx"
      label         = "resource.labels.xxx"
      name          = "xxx"
      filter        = "AND xxx = xxx"
      reducer       = "REDUCE_NONE"
      aligner       = "ALIGN_DELTA"
      alert = {
        "error" = {
          channel = "#error"
          window  = "300s"
          value   = 0.9
        }
      }
    }

    secrets = "auth_token: xoxb-xxx"
  }

  command = plan

  assert {
    condition     = google_monitoring_alert_policy.main["error"].conditions[0].condition_threshold[0].threshold_value == 0.9
    error_message = "`google_monitoring_alert_policy.main.conditions.condition_threshold.threshold_value` is invalid"
  }
}

run "valid_base_value" {
  module {
    source = "./"
  }

  variables {
    project_id = "project_id"

    target = {
      title         = "Title"
      metric        = "xxx.googleapis.com/xxx/xxx"
      resource_type = "xxx"
      label         = "resource.labels.xxx"
      name          = "xxx"
      filter        = "AND xxx = xxx"
      reducer       = "REDUCE_NONE"
      aligner       = "ALIGN_DELTA"
      base_value    = 15
      alert = {
        "warn" = {
          channel = "#warn"
          window  = "60s"
          value   = 0.75
        }
      }
    }

    secrets = "auth_token: xoxb-xxx"
  }

  command = plan

  assert {
    condition     = google_monitoring_alert_policy.main["warn"].conditions[0].condition_threshold[0].threshold_value == 11
    error_message = "`google_monitoring_alert_policy.main.conditions.condition_threshold.threshold_value` is invalid"
  }
}
