terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.53, < 5.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.53, < 5.0"
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-lb/v4.0.1"
  }

  provider_meta "google-beta" {
    module_name = "blueprints/terraform/terraform-google-lb/v4.0.1"
  }
}
