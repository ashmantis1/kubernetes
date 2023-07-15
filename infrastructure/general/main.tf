module "dns" {
    source = "./modules/dns"
    // DNS RFC 2186 details 
    dns_server = var.dns_server
    dns_key_name = var.dns_key_name
    dns_key_secret = var.dns_key_secret
    //DNS details
    dns_zone = var.dns_zone
    
}