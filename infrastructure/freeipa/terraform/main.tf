terraform {
  cloud {
    organization = "ashmantis"

    workspaces {
      name = "hl-freeipa-workspace"
    }
  }
}
module "nodes" {
    source = "./modules/nodes"
    proxmox_host = var.proxmox_host
    proxmox_user = var.proxmox_user
    proxmox_password = var.proxmox_password
    vm_id = var.vm_id

    dns_server = var.dns_server

    // vm details
    master_nodes = var.master_nodes
    master_count = var.master_count
    master_cpu = var.master_cpu
    master_memory = var.master_memory
    disk_size = var.disk_size
    cloud_image = var.cloud_image

}

module "dns" {
    source = "./modules/dns"
    // DNS RFC 2186 details 
    dns_server = var.dns_server
    dns_key_name = var.dns_key_name
    dns_key_secret = var.dns_key_secret
    //DNS details
    dns_zone = var.dns_zone
    reverse_zone = var.reverse_zone

    node_ips = module.nodes.master_ips
    service_name = var.service_name
}