variable "project_id" {
}

variable "region" {
}

variable "zone" {
}

variable "dns_name" {
  type = string
}

variable "name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "image" {
  type = string
}

variable "vpc_cidr_range" {
  type = list(string)
}

variable "other_org_project_id" {
  type = string
}

variable "other_peering_vpc" {
  type = string
}

variable "vpn_secret" {
  type = string
}