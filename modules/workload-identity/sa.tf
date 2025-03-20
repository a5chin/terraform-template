locals {
  pool_name = "projects/${var.project_number}/locations/global/workloadIdentityPools/${var.pool.id}"
}

data "google_service_account" "this" {
  for_each   = toset([for principal in var.principals : principal.service_account])
  account_id = each.value

  project = var.project_id
}

resource "google_service_account_iam_member" "this" {
  for_each = {
    for principal in var.principals : "${principal.service_account}_${principal.attribute.value}" => {
      service_account_id = data.google_service_account.this[principal.service_account].id
      member = (
        principal.subject != null ? "principal://iam.googleapis.com/${local.pool_name}/subject/${principal.subject}"
        : principal.group != null ? "principal://iam.googleapis.com/${local.pool_name}/subject/${principal.group}"
        : principal.attribute != null ? "principal://iam.googleapis.com/${local.pool_name}/subject/${principal.attribute.name}/${principal.attribute.value}"
        : "principalSet://iam.googleapis.com/${local.pool_name}/*"
      )
    }
  }
  member             = each.value.member
  service_account_id = each.value.service_account_id

  role = "roles/iam.workloadIdentityUser"
}
