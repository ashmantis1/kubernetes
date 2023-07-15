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


// Cluster name. Will be appended to all DNS records
variable "cluster_name" {
    description = "Cluster name"
    type = string 
}

// Node details
variable "master_ips" {
    description = "List of master node IP addresses"
    type = list(string)
}

variable "worker_ips" {
    description = "List of worker node IP addresses"
    type = list(string)
}