terraform {
  required_version = ">=1.7"

  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.4.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 5.22.0"
    }
  }
}
