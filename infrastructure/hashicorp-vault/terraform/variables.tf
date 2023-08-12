// DNS managment details
variable "dns_zone" {
    description = "DNS zone name"
    type = string 
}

variable "dns_server" {
    description = "DNS server IP address"
    type = string 
}

variable "dns_key_name" {
    description = "DNS TSIG key name. Must be fully qualified name"
    type = string 
}

variable "dns_key_secret" {
    description = "DNS TSIG key"
    type = string 
    sensitive = true
}

// Proxmox details

variable "proxmox_host" {
    description = "Proxmox host address (ip/domain:port) https will be appended"
    type = string 
}

variable "proxmox_password" {
    description = "Proxmox API password"
    type = string 
    sensitive = true
}
variable "proxmox_user" {
    description = "Proxmox API user"
    type = string 
}

// Node details
variable "nodes" {
    description = "list of nodes to deploy vms to"
    type = list(string)
}
variable "master_count" {
    description = "Number of master nodes"
    type = number 
}
variable "master_cpu" {
    description = "Master node CPU cores"
    type = number 
}

variable "master_memory" {
    description = "Master node RAM in MB"
    type = number 
}
variable "disk_size" {
    description = "Master node disk size in GB"
    type = number 
}