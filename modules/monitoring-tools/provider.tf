terraform {
  required_version = ">=1.7"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.22.0"
    }
    google-beta = {
      source  = "hashicorp/google"
      version = ">= 5.22.0"
    }
  }
}
