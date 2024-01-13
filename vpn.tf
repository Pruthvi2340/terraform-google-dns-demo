resource "google_compute_ha_vpn_gateway" "vpc-1-to-vpn-vpc-1" {
  name    = "${var.name}-ha-vpn-gateway-vpc-1-to-vpn-vpc"
  network = google_compute_network.vpc-1.id
  region  = var.region
}

resource "google_compute_vpn_tunnel" "vpc-1-to-vpn-vpc-1" {
  ike_version           = 2
  labels                = {}
  name                  = "${var.name}-vpn-tunnel-1"
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.vpn-vpc-to-vpc-1.self_link
  region                = var.region
  router                = google_compute_router.vpn-1.self_link
  shared_secret         = var.vpn_secret
  vpn_gateway           = google_compute_ha_vpn_gateway.vpc-1-to-vpn-vpc-1.self_link
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "vpc-1-to-vpn-vpc-1-2" {
  ike_version           = 2
  labels                = {}
  name                  = "${var.name}-vpn-tunnel-2"
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.vpn-vpc-to-vpc-1.self_link
  region                = var.region
  router                = google_compute_router.vpn-1.self_link
  shared_secret         = var.vpn_secret
  vpn_gateway           = google_compute_ha_vpn_gateway.vpc-1-to-vpn-vpc-1.self_link
  vpn_gateway_interface = 1
}

resource "google_compute_ha_vpn_gateway" "vpn-vpc-to-vpc-1" {
  name    = "${var.name}-ha-vpn-gateway-vpn-to-vpc-1"
  network = google_compute_network.vpn-vpc-1.id
  region  = var.region
}

resource "google_compute_vpn_tunnel" "vpn-vpc-to-vpc-1-1" {
  ike_version           = 2
  labels                = {}
  name                  = "${var.name}-vpn-tunnel-3"
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.vpc-1-to-vpn-vpc-1.self_link
  region                = var.region
  router                = google_compute_router.vpn-2.self_link
  shared_secret         = var.vpn_secret
  vpn_gateway           = google_compute_ha_vpn_gateway.vpn-vpc-to-vpc-1.self_link
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "vpn-vpc-to-vpc-1-2" {
  ike_version           = 2
  labels                = {}
  name                  = "${var.name}-vpn-tunnel-4"
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.vpc-1-to-vpn-vpc-1.self_link
  region                = var.region
  router                = google_compute_router.vpn-2.self_link
  shared_secret         = var.vpn_secret
  vpn_gateway           = google_compute_ha_vpn_gateway.vpn-vpc-to-vpc-1.self_link
  vpn_gateway_interface = 1
}