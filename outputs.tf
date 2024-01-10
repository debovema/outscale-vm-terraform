output "vm_public_ip" {
  description = "Public IP of the VM"
  value       = outscale_vm.vm.public_ip
}
