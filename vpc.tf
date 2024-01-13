resource "google_compute_network" "vpc-1" {
  name = "${var.name}-vpc"
  project = var.project_id
  auto_create_subnetworks = "false"
  routing_mode = "GLOBAL"
  mtu = 1460
  description = "VPC for ${var.project_id}"
}

# subnet.tf
resource "google_compute_subnetwork" "subnet-1" {
  name = "${google_compute_network.vpc-1.name}-subnet"
  project = var.project_id
  region = var.region
  network = google_compute_network.vpc-1.id
  ip_cidr_range = var.vpc_cidr_range[0]
  private_ip_google_access = "true"
  description = "Subnet for ${google_compute_network.vpc-1.name}"
}

resource "google_compute_network" "vpc-2-peering" {
  name = "${var.name}-vpc-2"
  project = var.project_id
  auto_create_subnetworks = "false"
  routing_mode = "GLOBAL"
  mtu = 1460
  description = "VPC for ${var.project_id}"
}

# subnet.tf
resource "google_compute_subnetwork" "subnet-2-peering" {
  name = "${google_compute_network.vpc-2-peering.name}-subnet"
  project = var.project_id
  region = var.region
  network = google_compute_network.vpc-2-peering.id
  ip_cidr_range = var.vpc_cidr_range[1]
  private_ip_google_access = "true"
  description = "Subnet for ${google_compute_network.vpc-1.name}"
}

resource "google_compute_network" "vpn-vpc-1" {
  name = "${var.name}-vpn"
  project = var.project_id
  auto_create_subnetworks = "false"
  routing_mode = "GLOBAL"
  mtu = 1460
  description = "VPC for ${var.project_id}"
}

# subnet.tf
resource "google_compute_subnetwork" "vpn-subnet-1" {
  name = "${google_compute_network.vpn-vpc-1.name}-vpn"
  project = var.project_id
  region = var.region
  network = google_compute_network.vpn-vpc-1.id
  ip_cidr_range = var.vpc_cidr_range[2]
  private_ip_google_access = "true"
  description = "Subnet for ${google_compute_network.vpc-1.name}"
}