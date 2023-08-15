terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.24.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://${var.proxmox_host}"
  username = "${var.proxmox_user}"
  password = "${var.proxmox_password}"
  //api_token = "${var.proxmox_api_token_id}=${var.proxmox_api_token}"
  insecure = true
}
resource "proxmox_virtual_environment_file" "debian_cloud_image" {
  content_type = "iso"
  datastore_id = "ISOs"
  node_name    = "newserver"

  source_file {
    path = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
    file_name = "debian12-server-cloudimgg.img"
 
  }
}

resource "proxmox_virtual_environment_file" "cloud_config" {
    content_type = "snippets"
    datastore_id = "ISOs"
    node_name    = "node2"
    source_file {
        path = "./cloudinit/user-data.yaml"
    }
}
resource "proxmox_virtual_environment_vm" "vault-masters" {
  count = var.master_count
  name        = "vault-server-0${count.index+1}"
  description = "Hashicorp vault server - managed by Terraform"
  tags        = ["terraform", "vault"]

  node_name = "${var.master_nodes[count.index]}"
  vm_id     = 2000 + count.index

  agent {
    enabled = true
  }

  cpu {
    cores = var.master_cpu
  }
  memory {
    dedicated = var.master_memory
  }
  disk {
    datastore_id = "SSD_Pool"
    file_id      = proxmox_virtual_environment_file.debian_cloud_image.id
    interface    = "scsi0"
    size = var.disk_size
    //file_format = "raw"
  }

  initialization {
    datastore_id = "SSD_Pool"
    dns {
        server = "${var.dns_server}"
    }
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  network_device {
    bridge = "vmbr0"
    vlan_id = 2000
  }

  operating_system {
    type = "l26"
  }


}