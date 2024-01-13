resource "google_compute_firewall" "iap_vpc_1_firewall" {
  name          = "${var.name}-iap-vpc-1-firewall"
  direction     = "INGRESS"
  network       = google_compute_network.vpc-1.id
  source_ranges = ["35.235.240.0/20"]
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "icmp_http_https_firewall" {
  name          = "${var.name}-icmp-http-https-firewall"
  direction     = "INGRESS"
  network       = google_compute_network.vpc-1.id
  source_ranges = ["0.0.0.0/0"]
  allow {
    ports    = ["80", "443", "53"]
    protocol = "tcp"
  }
  allow {
    ports    = ["53"]
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "iap_vpc_2_firewall" {
  name          = "${var.name}-iap-vpc-2-firewall"
  direction     = "INGRESS"
  network       = google_compute_network.vpc-2-peering.id
  source_ranges = ["35.235.240.0/20"]
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "icmp_http_https_firewall_2" {
  name          = "${var.name}-icmp-http-https-firewall-2"
  direction     = "INGRESS"
  network       = google_compute_network.vpc-2-peering.id
  source_ranges = ["0.0.0.0/0"]
  allow {
    ports    = ["80", "443", "53"]
    protocol = "tcp"
  }
  allow {
    ports    = ["53"]
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "iap_vpc_vpn_firewall" {
  name          = "${var.name}-iap-vpc-vpn-firewall"
  direction     = "INGRESS"
  network       = google_compute_network.vpn-vpc-1.id
  source_ranges = ["35.235.240.0/20"]
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "icmp_http_https_firewall_vpn" {
  name          = "${var.name}-icmp-http-https-firewall-vpn"
  direction     = "INGRESS"
  network       = google_compute_network.vpn-vpc-1.id
  source_ranges = ["0.0.0.0/0"]
  allow {
    ports    = ["80", "443", "53"]
    protocol = "tcp"
  }
  allow {
    ports    = ["53"]
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
}
