output "vpc-1-vm-ip" {
  value = google_compute_instance.vpc-1.network_interface.0.network_ip
}

output "vpc-2-vm-ip" {
  value = google_compute_instance.vpc-2.network_interface.0.network_ip
}

output "vpn-3-vpc-vm-ip" {
  value = google_compute_instance.vpc-3-vpn.network_interface.0.network_ip
}

output "other-org-vm-ip" {
  value = google_compute_instance.other-org-instance.network_interface.0.network_ip
}

output "dns_vm_1" {
  value = google_dns_record_set.instance-1.name
}

output "dns_vm_2" {
  value = google_dns_record_set.instance-2.name
}

output "dns_vm_3_vpn" {
  value = google_dns_record_set.instance-3-vpn.name
}

output "dns_vm_other_org" {
  value = google_dns_record_set.instance-4-other-org.name
}

output "vpn_gateway_1" {
  value = google_compute_ha_vpn_gateway.vpc-1-to-vpn-vpc-1.name
}

output "vpn_gateway_2" {
  value = google_compute_ha_vpn_gateway.vpn-vpc-to-vpc-1.name
}

output "vpn_tunnel_1_ip" {
  value = google_compute_vpn_tunnel.vpc-1-to-vpn-vpc-1.peer_ip
}

output "vpn_tunnel_2_ip" {
  value = google_compute_vpn_tunnel.vpc-1-to-vpn-vpc-1-2.peer_ip
}

output "vpn_tunnel_3_ip" {
  value = google_compute_vpn_tunnel.vpn-vpc-to-vpc-1-1.peer_ip
}

output "vpn_tunnel_4_ip" {
  value = google_compute_vpn_tunnel.vpn-vpc-to-vpc-1-2.peer_ip
}