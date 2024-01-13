variable "project_id" {
  default = "burner-prus"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "dns_name" {
  type = string
  default = "prus.com."
}

variable "name" {
  type = string
  default = "dns-demo"
}

variable "machine_type" {
  type = string
  default = "e2-micro"
}

variable "image" {
  type = string
  default = "debian-cloud/debian-11"
}

variable "vpc_cidr_range" {
  type = list(string)
  default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24"]
}

variable "other_org_project_id" {
  type = string
  default = "retail-demo-app-410314" 
}

variable "other_peering_vpc" {
  type = string
  default = "https://www.googleapis.com/compute/v1/projects/retail-demo-app-410314/global/networks/dns-test"
}

variable "vpn_secret" {
  type = string
  default = "123"
}