variable "vpc_cidr" {
  description = "VPC CIDR (https://docs.outscale.com/en/userguide/About-Nets.html)"
  default     = "192.168.1.0/24"
}

variable "vpc_public_subnet_cidr" {
  description = "Public subnet CIDR"
  default     = "192.168.1.0/26"
}

variable "image_id" {
  description = "OMI to deploy in the VM (https://docs.outscale.com/en/userguide/About-OMIs.html)"
  default     = "ami-69129fc8" # RHEL9
}

variable "public_key_file" {
  description = "SSH public key filename to use"
}

variable "vm_type_infra" {
  description = "The Outscale VM type (https://docs.outscale.com/en/userguide/VM-Types.html)"
  default     = "tinav5.c2r4p2"
}
