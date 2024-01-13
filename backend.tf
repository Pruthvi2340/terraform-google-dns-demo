terraform {
  backend "gcs" {
    bucket = "dns-demo-terraform-state"
    prefix = "dns/state"
  }
}