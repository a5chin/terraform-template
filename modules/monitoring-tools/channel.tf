resource "google_monitoring_notification_channel" "this" {
  for_each = var.target.alert

  display_name = upper(each.key)
  type         = "slack"

  labels = {
    channel_name = each.value.channel
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
