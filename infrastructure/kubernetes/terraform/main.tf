
terraform {
  cloud {
    organization = "ashmantis"

    workspaces {
      name = "ashman-hl-workspace"
    }
  }

}


module "nodes" {
    source = "./modules/nodes"
    proxmox_host = var.proxmox_host
    proxmox_user = var.proxmox_user
    proxmox_password = var.proxmox_password

    cluster_name = var.cluster_name
    dns_server = var.dns_server

    // Node details
    master_count = var.master_count
    worker_count = var.worker_count
    // master 
    master_cpu = var.master_cpu
    master_memory = var.master_memory
    // worker
    worker_cpu = var.worker_cpu    
    worker_memory = var.worker_memory

}

module "dns" {
    source = "./modules/dns"
    // DNS RFC 2186 details 
    dns_server = var.dns_server
    dns_key_name = var.dns_key_name
    dns_key_secret = var.dns_key_secret
    //DNS details
    dns_zone = var.dns_zone
    //k8s cluster details
    cluster_name = var.cluster_name
    //k8s nodes details
    master_ips = module.nodes.master_ips
    worker_ips = module.nodes.worker_ips
}