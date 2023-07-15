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

// Cluster name. Will be appended to all DNS records
variable "cluster_name" {
    description = "Cluster name"
    type = string 
}

variable "master_count" {
    description = "Number of master nodes"
    type = number 
}

variable "worker_count" {
    description = "Number of worker nodes"
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

variable "worker_cpu" {
    description = "Worker node CPU cores"
    type = number 
}

variable "worker_memory" {
    description = "Worker node RAM in MB"
    type = number 
}