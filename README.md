# Release version 1.0.0
1. CLoud DNS demo with the different Senario

* DNS with VPN connection with the different VPC inside single organization
* DNS with VPC peering with the different VPC inside single organization
* DNS with VPC peering with the different VPC outside organization

* 3 VPC with single organization
* 1 VPC with other organization
* 3 compute instance with single organization
* 1 compute instance with other organization
* 2 VPN gateway with single organization
* 4 VPN tunnel with single organization

# Connection summary:

1. VPC-1 to VPC-2 = VPC Peering
2. VPC-1 to VPC-3-vpn = VPN connection with VPC-1 and VPC-3 via VPN tunnel
3. VPC-1 to VPC-other = VPN Peering with other organization


# Use terraform.tfvars file with below values:
```
project_id = ""
region = "us-central1"
zone = "us-central1-a"
dns_name = "prus.com."
name= "dns-demo"
machine_type = "e2-micro"
image = "debian-cloud/debian-11"
vpc_cidr_range = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24"]
other_org_project_id = "<project_id_other_org>" 
other_peering_vpc = "https://www.googleapis.com/compute/v1/projects/<project_id_other_org>/global/networks/dns-test"
vpn_secret = "123"
```

# Terraform commands info

1. Basic commands
```
terraform init
terraform plan
terraform apply 
terraform destroy
```
2. Auto approve commands
```
terraform apply -auto-approve
terraform destroy -auto-approve
```
3. To Recreate the resource which is already created
```
terraform taint google_compute_instance.vpc-2   # taint condition applies only first time of terraform apply
terraform apply -auto-approve                   # If applied again it will not recreate the resource
```
4. To untaint the terraform resource
```
terraform untaint google_compute_instance.vpc-2
```
5. Destroy single resource
```
terraform destroy -target=google_compute_instance.vpc-1 -auto-approve
```
6. Destroy multiple specific resource
```
terraform destroy --target=google_compute_instance.vpc-2 --target=google_compute_instance.vpc-3-vpn --target=google_compute_instance.other-org-instance -auto-approve
```
