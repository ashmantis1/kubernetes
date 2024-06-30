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

variable "node_ips" {
    description = "Node IP address"
    type = list(string)
}

variable "service_name" {
    description = "Service name"
    type = string 
}

variable "reverse_zone" {
    description = "Reverse zone name"
    type = string 
}