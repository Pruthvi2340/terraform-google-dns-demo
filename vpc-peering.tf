resource "google_compute_network_peering" "peering-vpc-1-to-vpc-2" {
  name = "${var.name}-peering-vpc-1-to-vpc-2"
  network = google_compute_network.vpc-1.self_link
  peer_network = google_compute_network.vpc-2-peering.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
  stack_type = "IPV4_ONLY"
}

resource "google_compute_network_peering" "peering-vpc-2-to-vpc-1" {
  name = "${var.name}-peering-vpc-2-to-vpc-1"
  network = google_compute_network.vpc-2-peering.self_link
  peer_network = google_compute_network.vpc-1.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
  stack_type = "IPV4_ONLY"
}

resource "google_compute_network_peering" "vpc-1-to-other-org-vpc" {
    export_custom_routes                = true
    export_subnet_routes_with_public_ip = true
    import_custom_routes                = true
    import_subnet_routes_with_public_ip = true
    name                                = "${var.name}-other-org-vpc-peering"
    network                             = google_compute_network.vpc-1.self_link
    peer_network                        = var.other_peering_vpc 
    stack_type                          = "IPV4_ONLY"
}