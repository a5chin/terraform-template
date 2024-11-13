resource "google_monitoring_notification_channel" "main" {
  for_each = local.levels

  display_name = upper(each.key)
  type         = "slack"

  labels = {
    channel_name = each.value
  }

  sensitive_labels {
    auth_token = yamldecode(var.secrets)["auth_token"]
  }

  lifecycle {
    ignore_changes = [
      labels["team"]
    ]
  }
}
