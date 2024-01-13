# google_compute_instance.vpc-1:
resource "google_compute_instance" "vpc-1" {
  can_ip_forward      = true
  deletion_protection = false
  machine_type        = "e2-micro"
  metadata = {
    "enable-osconfig" = "TRUE"
    "startup-script"  = <<-EOT
            #!/bin/bash
            echo "Running startup script..."
            set -x
            apt update
            apt install apache2 -y
            export hostname="$(cat /etc/hostname)"
            echo "$(cat /etc/hostname)" > /var/www/html/index.html
            echo "Happy DNS resolution\n $hostname" >>  /var/www/html/index.html
        EOT
  }
  name = "${var.name}-1"
  tags = [
    "http-server",
    "https-server",
    "lb-health-check",
  ]
  zone = var.zone

  boot_disk {
    auto_delete = true
    initialize_params {
      image = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-11-bullseye-v20240110"
      size  = 10
      type  = "pd-standard"
    }
  }

  network_interface {
    internal_ipv6_prefix_length = 0
    network                     = google_compute_network.vpc-1.self_link
    queue_count                 = 0
    stack_type                  = "IPV4_ONLY"
    subnetwork                  = google_compute_subnetwork.subnet-1.self_link
    subnetwork_project          = var.project_id
  }
  depends_on = [google_compute_router_nat.vpc-1-nat]
}

# google_compute_instance.vpc-2:
resource "google_compute_instance" "vpc-2" {
  can_ip_forward      = true
  deletion_protection = false
  machine_type        = var.machine_type
  metadata = {
    "enable-osconfig" = "TRUE"
    "startup-script"  = <<-EOT
            #!/bin/bash
            echo "Running startup script..."
            set -x
            apt update
            apt install apache2 -y
            export hostname="$(cat /etc/hostname)"
            echo "$(cat /etc/hostname)" > /var/www/html/index.html
            echo "Happy DNS resolution\n $hostname" >>  /var/www/html/index.html
        EOT
  }
  name = "${var.name}-2"
  tags = [
    "http-server",
    "https-server",
    "lb-health-check",
  ]
  zone = var.zone

  boot_disk {
    auto_delete = true
    initialize_params {
      image = var.image
      size  = 10
      type  = "pd-standard"
    }
  }

  network_interface {
    internal_ipv6_prefix_length = 0
    network                     = google_compute_network.vpc-2-peering.self_link
    queue_count                 = 0
    stack_type                  = "IPV4_ONLY"
    subnetwork                  = google_compute_subnetwork.subnet-2-peering.self_link
    subnetwork_project          = var.project_id
  }
  depends_on = [google_compute_router_nat.vpc-2-nat]
}

# google_compute_instance.vpc-3-vpn:
resource "google_compute_instance" "vpc-3-vpn" {
  can_ip_forward      = true
  deletion_protection = false
  machine_type        = var.machine_type
  metadata = {
    "enable-osconfig" = "TRUE"
    "startup-script"  = <<-EOT
            #!/bin/bash
            echo "Running startup script..."
            set -x
            apt update
            apt install apache2 -y
            export hostname="$(cat /etc/hostname)"
            echo "$(cat /etc/hostname)" > /var/www/html/index.html
            echo "Happy DNS resolution\n $hostname" >>  /var/www/html/index.html
        EOT
  }
  name = "${var.name}-vpn"
  tags = [
    "http-server",
    "https-server",
    "lb-health-check",
  ]

  zone = var.zone

  boot_disk {
    auto_delete = true

    initialize_params {
      image = var.image
      size  = 10
      type  = "pd-standard"
    }
  }

  network_interface {
    internal_ipv6_prefix_length = 0
    network                     = google_compute_network.vpn-vpc-1.self_link
    queue_count                 = 0
    stack_type                  = "IPV4_ONLY"
    subnetwork                  = google_compute_subnetwork.vpn-subnet-1.self_link
    subnetwork_project          = var.project_id
  }
  depends_on = [google_compute_router_nat.vpn-nat]
}

# google_compute_instance.other-org-instance:
resource "google_compute_instance" "other-org-instance" {
  provider            = google.other-org
  can_ip_forward      = true
  deletion_protection = false
  machine_type        = var.machine_type
  metadata = {
    "enable-osconfig" = "TRUE"
    "startup-script"  = <<-EOT
            #!/bin/bash
            echo "Running startup script..."
            set -x
            apt update
            apt install apache2 -y
            export hostname="$(cat /etc/hostname)"
            echo "$(cat /etc/hostname)" > /var/www/html/index.html
            echo "Happy DNS resolution\n $hostname" >>  /var/www/html/index.html
        EOT
  }
  name = "${var.name}-other-org"
  tags = [
    "http-server",
    "https-server",
    "lb-health-check",
  ]

  zone = var.zone

  boot_disk {
    auto_delete = true

    initialize_params {
      image = var.image
      size  = 10
      type  = "pd-standard"
    }
  }

  network_interface {
    internal_ipv6_prefix_length = 0
    network                     = google_compute_network.other-org-vpc.self_link
    queue_count                 = 0
    stack_type                  = "IPV4_ONLY"
    subnetwork                  = google_compute_subnetwork.other-org-subnet.self_link
    subnetwork_project          = var.other_org_project_id
  }
  depends_on = [google_compute_router_nat.other-org-nat]
}