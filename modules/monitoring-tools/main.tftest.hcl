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

run "valid_no_filter" {
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
      reducer       = "REDUCE_NONE"
      aligner       = "ALIGN_DELTA"
      alert = {
        "error" = {
          channel = "#error"
          window  = "300s"
          value   = 0.8
        }
      }
    }

    secrets = "auth_token: xoxb-xxx"
  }

  command = plan

  assert {
    condition     = google_monitoring_alert_policy.main["error"].project == var.project_id
    error_message = "`var.target.filter` is not optional."
  }
}

run "invalid_label" {
  module {
    source = "./"
  }

  variables {
    project_id = "project_id"

    target = {
      title         = "Title"
      metric        = "xxx.googleapis.com/xxx/xxx"
      resource_type = "xxx"
      label         = "resource.xxx"
      name          = "xxx"
      filter        = "AND xxx = xxx"
      reducer       = "REDUCE_NONE"
      aligner       = "ALIGN_DELTA"
      alert = {
        "warn" = {
          channel = "#warn"
          window  = "300s"
          value   = 0.65
        }
      }
    }

    secrets = "auth_token: xoxb-xxx"
  }

  command = plan

  expect_failures = [
    var.target.label,
  ]
}

run "invalid_filter" {
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
      filter        = "AN xxx = xxx"
      reducer       = "REDUCE_NONE"
      aligner       = "ALIGN_DELTA"
      alert = {
        "error" = {
          channel = "#error"
          window  = "300s"
          value   = 0.8
        }
      }
    }

    secrets = "auth_token: xoxb-xxx"
  }

  command = plan

  expect_failures = [
    var.target.filter,
  ]
}

run "invalid_channel" {
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
          channel = "error"
          window  = "300s"
          value   = 0.95
        }
        "warn" = {
          channel = "warn"
          window  = "300s"
          value   = 0.8
        }
      }
    }

    secrets = "auth_token: xoxb-xxx"
  }

  command = plan

  expect_failures = [
    var.target.alert["error"].channel,
    var.target.alert["warn"].channel,
  ]
}
