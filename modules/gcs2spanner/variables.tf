variable "project_id" {
  description = "The ID of the Project"
  type        = string
}

variable "location" {
  description = "The location of the Dataflow"
  type        = string
}

variable "dataflow" {
  description = "The Dataflow parameters"
  type = object({
    name              = string
    gcsPath           = optional(string, "gs://dataflow-templates/2024-01-30-01_RC00/GCS_Avro_to_Cloud_Spanner")
    temp_gcs_location = string
    parameters = object({
      instanceId = string
      databaseId = string
      subnetwork = string
    })
    sa = object({
      id = string
    })
  })
}

variable "functions" {
  description = <<EOF
    The Cloud Functions parameter for creating Dataflow jobs,
    using gcsPath as the Google-provided template available in the public GCS bucket
  EOF
  type = object({
    name                             = string
    bucket                           = string
    max_instance_count               = optional(number, 1)
    min_instance_count               = optional(number, 0)
    available_memory                 = optional(string, "512Mi")
    timeout_seconds                  = optional(number, 60)
    max_instance_request_concurrency = optional(number, 80)
    available_cpu                    = optional(number, 1)
    sa = object({
      id = string
    })
    event = object({
      sa = object({
        id = string
      })
    })
  })
}

variable "gcs" {
  description = "The GCS parameters to receive aggregate data"
  type = object({
    name = string
    lifecycle_rule = optional(
      object({
        age    = number
        action = string
        }), {
        age    = 90
        action = "Delete"
      }
    )
    allows = set(string)
  })
}

variable "vpc" {
  description = "Settings for VPC"
  type = object({
    network = object({
      name = string
    })
    subnetwork = object({
      name          = string
      ip_cidr_range = string
    })
  })
}
