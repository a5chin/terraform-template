resource "google_monitoring_alert_policy" "main" {
  for_each = local.levels

  display_name = "[${upper(each.value)}] ${var.target.name} ${var.target.title}"

  conditions {
    display_name = "[${upper(each.value)}] ${var.target.name} - ${var.target.title}"

    condition_threshold {
      filter = <<EOF
        metric.type = "${var.target.metric}"
        AND resource.type = "${var.target.resource_type}"
        AND ${var.target.label} = ${var.target.name}
        AND ${var.target.filter}
      EOF

      aggregations {
        alignment_period     = var.target.threshold[each.value].window
        cross_series_reducer = var.target.reducer
        per_series_aligner   = var.target.aligner
      }

      trigger {
        count = 1
      }

      threshold_value = (
        var.target.base_value == 1 ?
        var.target.threshold[each.value].value :
        floor(var.target.base_value * var.target.threshold[each.value].value)
      )

      comparison = "COMPARISON_GT"
      duration   = "0s"
    }
  }

  alert_strategy {
    auto_close = "604800s"
  }

  combiner              = "OR"
  enabled               = "true"
  notification_channels = []
}
