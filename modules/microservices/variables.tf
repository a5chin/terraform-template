variable "project_id" {
  description = "The ID of Google Cloud Platform"
  type        = string
}

variable "location" {
  description = "The location of the resource"
  type        = string
}

variable "backend" {
  description = "The backend settings"
  type = object({
    name               = string
    image              = string
    max_instance_count = optional(number, 1)
    min_instance_count = optional(number, 0)
    concurrency        = optional(number, 80)
    timeout_seconds    = optional(number, 60)
    cpu                = optional(string, "1000m")
    memory             = optional(string, "1024Mi")
    env = object({
      HOSTNAME   = string
      DB_USER    = string
      DB_PWD     = string
      DB_NAME    = string
      DB_TCPHOST = string
      DB_PORT    = number
    })
    executor = object({
      id = string
      roles = optional(
        set(string), [
          "roles/cloudsql.client",
          "roles/cloudtrace.agent",
        ]
      )
    })
    invoker = object({
      ids = set(string)
      emails = optional(
        set(string), []
      )
    })
  })
}

variable "frontend" {
  description = "The frontend settings"
  type = object({
    name               = string
    image              = string
    max_instance_count = optional(number, 1)
    min_instance_count = optional(number, 0)
    concurrency        = optional(number, 80)
    timeout_seconds    = optional(number, 60)
    cpu                = optional(string, "1000m")
    memory             = optional(string, "1024Mi")
    executor = object({
      id = string
      roles = optional(
        set(string), [
          "roles/cloudtrace.agent",
        ]
      )
    })
    invoker = object({
      ids = set(string)
      emails = optional(
        set(string), []
      )
    })
  })
}

variable "db" {
  description = "The Cloud SQL settings"
  type = object({
    instance_name = string
    database_name = string
    version       = optional(string, "db-f1-micro")
    charset       = optional(string, "utf8mb4")
    collation     = optional(string, "utf8mb4_unicode_ci")
  })
}
