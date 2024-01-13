terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.11" # Use the desired version constraint
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "google" {
  alias       = "other-org"
  project     = var.other_org_project_id
  credentials = file("service-account.json")
  region      = var.region
  zone        = var.zone
}
