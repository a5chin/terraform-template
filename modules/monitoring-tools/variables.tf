variable "project_id" {
  description = "The ID of Google Cloud Platform."
  type        = string
}

variable "location" {
  description = "The location of the resource."
  type        = string
}

variable "target" {
  description = <<EOF
    The target information for monitoring.
    `base_value` is used to calculate a numeric value based on the target resource.
    Specifically, it is used to obtain a percentage, as in `floor(base_value * threshold.value)`.
  EOF
  type = object({
    title         = string
    metric        = string
    resource_type = string
    label         = string
    name          = string
    filter        = string
    reducer       = string
    aligner       = string
    base_value    = optional(number, 1)
    threshold = map(
      object({
        value  = number
        window = string
      })
    )
  })
}

variable "channels" {
  description = "Channel variable that contains `error` and `warn` as keys"
  type        = map(string)
}

variable "secrets" {
  description = <<EOF
    The token required for notifications to Slack.
    The variable is required for monitoring.
  EOF
  type        = string
}
