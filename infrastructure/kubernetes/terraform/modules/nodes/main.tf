terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.35.1"
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
  //20230531-1397
  source_file {
    path = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
    file_name = "debian12-server-cloudimg.img"
 
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
resource "proxmox_virtual_environment_vm" "k8s-masters" {
  count = var.master_count
  name        = "k8s-master-0${count.index+1}"
  description = "Control plane kubernetes node - managed by Terraform"
  tags        = ["terraform", "k8s", "master"]

  node_name = "${var.master_nodes[count.index]}"
  vm_id     = 1000 + count.index

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
    size = 32
    //file_format = "raw"
  }

  initialization {
    datastore_id = "SSD_Pool"
    dns {
        server = "8.8.8.8"
    }
    ip_config {
      ipv4 {
        address = "10.10.10.${count.index+1}/16"
        gateway = "10.10.0.1"
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
resource "proxmox_virtual_environment_vm" "k8s-workers" {
  count = var.worker_count
  name        = "k8s-worker-0${count.index+1}"
  description = "Worker kubernetes node - managed by Terraform"
  tags        = ["terraform", "k8s", "worker"]

  node_name = "${var.worker_nodes[count.index]}"
  vm_id     = 1000 + count.index+var.master_count+1

  agent {
    enabled = true
  }

  cpu {
    cores = var.worker_cpu
  }
  memory {
    dedicated = var.worker_memory
  }
  disk {
    datastore_id = "SSD_Pool"
    file_id      = proxmox_virtual_environment_file.debian_cloud_image.id
    interface    = "scsi0"
    size = 32
    //file_format = "raw"
  }

  initialization {
    datastore_id = "SSD_Pool"
    dns {
        server = "8.8.8.8"
    }
    ip_config {
      ipv4 {
        address = "10.10.10.${var.master_count+count.index+1}/16"
        gateway = "10.10.0.1"
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


