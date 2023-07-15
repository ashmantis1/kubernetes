output "master_ips" {
    value = [for i in proxmox_virtual_environment_vm.k8s-masters: i.ipv4_addresses[1][0]]
}
output "worker_ips" {
    value = [for i in proxmox_virtual_environment_vm.k8s-workers: i.ipv4_addresses[1][0]]
}