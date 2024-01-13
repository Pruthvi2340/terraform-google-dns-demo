resource "google_dns_managed_zone" "private_zone" {
  dns_name   = var.dns_name
  name       = var.name
  project    = var.project_id
  visibility = "private"
  private_visibility_config {
    networks {
      network_url = google_compute_network.vpc-1.self_link
    }
    networks {
      network_url = google_compute_network.vpc-2-peering.self_link
    }
    networks {
      network_url = google_compute_network.vpn-vpc-1.self_link
    }
  }
}

resource "google_dns_record_set" "instance-1" {
  name         = "${google_compute_instance.vpc-1.name}.${google_dns_managed_zone.private_zone.dns_name}"
  managed_zone = google_dns_managed_zone.private_zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_instance.vpc-1.network_interface[0].network_ip]
}

resource "google_dns_record_set" "instance-2" {
  name         = "${google_compute_instance.vpc-2.name}.${google_dns_managed_zone.private_zone.dns_name}"
  managed_zone = google_dns_managed_zone.private_zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_instance.vpc-2.network_interface[0].network_ip]
}

resource "google_dns_record_set" "instance-3-vpn" {
  name         = "${google_compute_instance.vpc-3-vpn.name}.${google_dns_managed_zone.private_zone.dns_name}"
  managed_zone = google_dns_managed_zone.private_zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_instance.vpc-3-vpn.network_interface[0].network_ip]
}

resource "google_dns_record_set" "instance-4-other-org" {
  name         = "${google_compute_instance.other-org-instance.name}.${google_dns_managed_zone.private_zone.dns_name}"
  managed_zone = google_dns_managed_zone.private_zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_instance.other-org-instance.network_interface[0].network_ip]
}

resource "google_dns_managed_zone" "private_zone-other-org" {
  provider   = google.other-org
  dns_name   = var.dns_name
  name       = var.name
  visibility = "private"
  private_visibility_config {
    networks {
      network_url = google_compute_network.other-org-vpc.self_link
    }
  }
}

resource "google_dns_record_set" "instance-1-1" {
  provider     = google.other-org
  name         = "${google_compute_instance.vpc-1.name}.${google_dns_managed_zone.private_zone-other-org.dns_name}"
  managed_zone = google_dns_managed_zone.private_zone-other-org.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_instance.vpc-1.network_interface[0].network_ip]
}

resource "google_dns_record_set" "instance-2-1" {
  provider     = google.other-org
  name         = "${google_compute_instance.vpc-2.name}.${google_dns_managed_zone.private_zone-other-org.dns_name}"
  managed_zone = google_dns_managed_zone.private_zone-other-org.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_instance.vpc-2.network_interface[0].network_ip]
}

resource "google_dns_record_set" "instance-3-vpn-1" {
  provider     = google.other-org
  name         = "${google_compute_instance.vpc-3-vpn.name}.${google_dns_managed_zone.private_zone-other-org.dns_name}"
  managed_zone = google_dns_managed_zone.private_zone-other-org.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_instance.vpc-3-vpn.network_interface[0].network_ip]
}

resource "google_dns_record_set" "instance-4-other-org-1" {
  provider     = google.other-org
  name         = "${google_compute_instance.other-org-instance.name}.${google_dns_managed_zone.private_zone-other-org.dns_name}"
  managed_zone = google_dns_managed_zone.private_zone-other-org.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_instance.other-org-instance.network_interface[0].network_ip]
}