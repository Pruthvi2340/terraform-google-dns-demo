# Nat configuration for the vpc-1 Network VPC below
resource "google_compute_router" "vpc-1" {
  encrypted_interconnect_router = true
  name                          = "${var.name}-${google_compute_network.vpc-1.name}"
  network                       = google_compute_network.vpc-1.self_link
  region                        = var.region
}

# Nat configuration for the vpc-2 Network VPC below
resource "google_compute_router" "vpc-2-peering" {
  encrypted_interconnect_router = true
  name                          = "${var.name}-${google_compute_network.vpc-2-peering.name}"
  network                       = google_compute_network.vpc-2-peering.self_link
  region                        = var.region
}

# Nat configuration for the vpn Network VPC below
resource "google_compute_router" "vpn-to-vpc-1" {
  encrypted_interconnect_router = true
  name                          = "${var.name}-${google_compute_network.vpn-vpc-1.name}"
  network                       = google_compute_network.vpn-vpc-1.self_link
  region                        = var.region

}

# Nat configuration for the vpn Network VPC below
resource "google_compute_router" "other-org-router" {
  provider                      = google.other-org
  encrypted_interconnect_router = true
  name                          = "${var.name}-${google_compute_network.other-org-vpc.name}"
  network                       = google_compute_network.other-org-vpc.self_link
  region                        = var.region
}

# VPN tunnel associated router configuration below for vpc-1 Network VPC
resource "google_compute_router" "vpn-1" {
  encrypted_interconnect_router = false
  name                          = "${var.name}-${google_compute_network.vpc-1.name}-vpn-1"
  network                       = google_compute_network.vpc-1.self_link
  region                        = var.region
  bgp {
    asn            = 64512
    advertise_mode = "DEFAULT"
  }
}

resource "google_compute_router_interface" "vpn-1-interface" {
  name       = "${var.name}-${google_compute_network.vpc-1.name}-1"
  router     = google_compute_router.vpn-1.name
  region     = var.region
  vpn_tunnel = google_compute_vpn_tunnel.vpc-1-to-vpn-vpc-1.self_link
  ip_range   = "169.254.1.1/30"
}

resource "google_compute_router_interface" "vpn-2-interface" {
  name       = "${var.name}-${google_compute_network.vpc-1.name}-2"
  router     = google_compute_router.vpn-1.name
  region     = var.region
  vpn_tunnel = google_compute_vpn_tunnel.vpc-1-to-vpn-vpc-1-2.self_link
  ip_range   = "169.254.2.1/30"
}

# VPN tunnel associated router configuration below for vpn-to-vpc-1 Network VPC
resource "google_compute_router" "vpn-2" {
  encrypted_interconnect_router = false
  name                          = "${var.name}-${google_compute_network.vpn-vpc-1.name}-vpn-2"
  network                       = google_compute_network.vpn-vpc-1.self_link
  region                        = var.region
  bgp {
    asn            = 64513
    advertise_mode = "DEFAULT"
  }
}

resource "google_compute_router_interface" "vpn-2-1-interface" {
  name       = "${var.name}-${google_compute_network.vpn-vpc-1.name}-1"
  router     = google_compute_router.vpn-2.name
  region     = var.region
  vpn_tunnel = google_compute_vpn_tunnel.vpn-vpc-to-vpc-1-1.self_link
  ip_range   = "169.254.1.2/30"
}

resource "google_compute_router_interface" "vpc-2-2-interface" {
  name       = "${var.name}-${google_compute_network.vpn-vpc-1.name}-2"
  router     = google_compute_router.vpn-2.name
  region     = var.region
  vpn_tunnel = google_compute_vpn_tunnel.vpn-vpc-to-vpc-1-2.self_link
  ip_range   = "169.254.2.2/30"
}

resource "google_compute_router_peer" "router1_peer1" {
  name                      = "router1-peer1"
  router                    = google_compute_router.vpn-1.name
  region                    = var.region
  peer_ip_address           = "169.254.1.2"
  peer_asn                  = 64513
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.vpn-1-interface.name
}

resource "google_compute_router_peer" "router1_peer2" {
  name                      = "router1-peer2"
  router                    = google_compute_router.vpn-1.name
  region                    = var.region
  peer_ip_address           = "169.254.2.2"
  peer_asn                  = 64513
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.vpn-2-interface.name
}

resource "google_compute_router_peer" "router1_peer3" {
  name                      = "router1-peer2-1"
  router                    = google_compute_router.vpn-2.name
  region                    = var.region
  peer_ip_address           = "169.254.1.1"
  peer_asn                  = 64512
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.vpn-2-1-interface.name
}

resource "google_compute_router_peer" "router1_peer4" {
  name                      = "router1-peer2-2"
  router                    = google_compute_router.vpn-2.name
  region                    = var.region
  peer_ip_address           = "169.254.2.1"
  peer_asn                  = 64512
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.vpc-2-2-interface.name
}