# data "https" "jwks" {
#   url = "${var.pool_provider.issuer_uri}/.well-known/jwks"
# }

resource "google_iam_workload_identity_pool_provider" "this" {
  project = var.project_id

  description  = var.pool_provider.description
  display_name = coalesce(var.pool_provider.display_name, var.pool_provider.id, var.pool.id)

  workload_identity_pool_id          = google_iam_workload_identity_pool.this.workload_identity_pool_id
  workload_identity_pool_provider_id = coalesce(var.pool_provider.id, var.pool.id)

  attribute_condition = var.pool_provider.attribute_condition
  attribute_mapping = merge(
    { for claim in var.pool_provider.attribute_claims : "attribute.${claim}" => "assertion.${claim}" },
    var.pool_provider.attribute_mappings,
  )

  oidc {
    issuer_uri = var.pool_provider.issuer_uri
    # jwks_json = jsonencode({
    #   keys = [
    #     for entry in jsondecode(data.https.jwks.response_body).keys : {
    #       for key, value in entry : key => value if contains(["kty", "alg", "use", "kid", "n", "e", "x", "y", "crv"], key)
    #     }
    #   ]
    # })
  }

  lifecycle {
    ignore_changes = [oidc]
  }

  depends_on = [
    google_project_service.this,
  ]
}
