variable "project_id" {
  description = "The ID of the Project"
  type        = string
}

variable "location" {
  description = "The location of the Cloud Scheduler"
  type        = string
}

variable "scheduler" {
  description = "The config for the Cloud Scheduler"
  type = object({
    name      = string
    schedule  = string
    time_zone = optional(string, "Asia/Tokyo")
    body      = optional(map(string), {})
    sa = object({
      id = string
    })
  })
}

variable "functions" {
  description = "The config for the Cloud Run Functions"
  type = object({
    name                             = string
    bucket                           = string
    runtime                          = optional(string, "python312")
    entry_point                      = optional(string, "http_handler")
    max_instance_count               = optional(number, 1)
    min_instance_count               = optional(number, 0)
    available_memory                 = optional(string, "256M")
    timeout_seconds                  = optional(number, 60)
    max_instance_request_concurrency = optional(number, 80)
    available_cpu                    = optional(string, "1")
    sa = object({
      id    = string
      roles = optional(set(string), [])
    })
    environment_variables = optional(
      map(string), {
        "LOG_EXECUTION_ID" = true
      }
    )
  })
}
