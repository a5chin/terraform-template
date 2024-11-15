variable "bigquery" {
  description = "The bigquery settings"
  type = object({
    dataset         = string
    table           = string
    view            = string
    expiration_days = number
  })
}

variable "logging" {
  type = object({
    target = string
    filter = string
  })
}
