resource "outscale_keypair" "keypair" {
  public_key   = file(var.public_key_file)
}

data "outscale_subregions" "all_subregions" {
}

resource "outscale_net" "vpc" {
  ip_range = var.vpc_cidr
}

resource "outscale_subnet" "vpc_subnet_public_aza" {
  net_id         = outscale_net.vpc.net_id
  ip_range       = var.vpc_public_subnet_cidr
  subregion_name = data.outscale_subregions.all_subregions.subregions[0].subregion_name # first AZ of the current region
}

resource "outscale_vm" "vm" {
  image_id           = var.image_id
  vm_type            = var.vm_type_infra
  keypair_name       = outscale_keypair.keypair.keypair_name
  subnet_id          = outscale_subnet.vpc_subnet_public_aza.subnet_id
  security_group_ids = [outscale_security_group.sg_allow_ssh.id]
}

resource "outscale_security_group" "sg_allow_ssh" {
  description         = "Permit SSH access to bastion"
  security_group_name = "seg-allow-ssh"
  net_id              = outscale_net.vpc.net_id
}

resource "outscale_security_group_rule" "sg-ssh" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.sg_allow_ssh.id

  from_port_range = "22"
  to_port_range   = "22"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}

resource "outscale_internet_service" "igw" {
}

resource "outscale_internet_service_link" "internet_service_link01" {
  internet_service_id = outscale_internet_service.igw.internet_service_id
  net_id              = outscale_net.vpc.net_id
}

resource "outscale_route_table" "route_table_public_aza" {
  net_id = outscale_net.vpc.net_id
}

resource "outscale_route" "route-IGW-aza" {
  destination_ip_range = "0.0.0.0/0"
  gateway_id           = outscale_internet_service.igw.id
  route_table_id       = outscale_route_table.route_table_public_aza.route_table_id
}

resource "outscale_route_table_link" "route_table_public_aza" {
  subnet_id      = outscale_subnet.vpc_subnet_public_aza.subnet_id
  route_table_id = outscale_route_table.route_table_public_aza.id
}

resource "outscale_public_ip" "vm_public_ip" {
}

resource "outscale_public_ip_link" "public_ip_vm_link" {
  public_ip = outscale_public_ip.vm_public_ip.public_ip
  vm_id     = outscale_vm.vm.vm_id
}
