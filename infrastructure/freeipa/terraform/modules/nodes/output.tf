output "master_ips" {
    value = [for i in proxmox_virtual_environment_vm.freeipa-masters: i.ipv4_addresses[1][0]]
}