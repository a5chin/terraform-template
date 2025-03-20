variable "project_id" {
  description = "The project ID of Google Cloud Platform."
  type        = string
}

variable "project_number" {
  description = "The project number of Google Cloud Platform."
  type        = string
}

variable "pool" {
  description = "The workload identity pool configuration."
  type = object({
    id           = string
    display_name = optional(string, null)
    description  = optional(string, "Managed by Terraform")
  })
}

variable "pool_provider" {
  description = "The workload identity pool provider configuration."
  type = object({
    id                  = optional(string, null)
    display_name        = optional(string, null)
    description         = optional(string, "Managed by Terraform")
    attribute_condition = string
    attribute_mappings = optional(
      map(string), {
        "google.subject" = "assertion.sub"
    })
    attribute_claims = optional(
      set(string), []
    )
    issuer_uri = optional(string, "https://token.actions.githubusercontent.com")
  })
}

variable "principals" {
  description = "The workload identity pool provider principals."
  type = list(
    object({
      service_account = string
      subject         = optional(string)
      group           = optional(string)
      attribute = optional(object({
        name  = string
        value = string
      }))
    })
  )
}
