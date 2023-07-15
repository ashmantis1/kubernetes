provider "dns" {
    update {
        server        = "${var.dns_server}"
        key_name      = "${var.dns_key_name}"
        key_algorithm = "hmac-sha256"
        key_secret    = "${var.dns_key_secret}"
    }
}
resource "dns_a_record_set" "npm-lb-endpoint" {
  zone = var.dns_zone
  name = "*"
  addresses = ["192.168.1.250"]
  
  ttl = 3600
}
// Temporary OKD names
resource "dns_a_record_set" "okd-masters" {
  zone = var.dns_zone
  count = 3
  name = "master0${count.index+1}.okd"
  addresses = [
    "10.10.0.${20 + count.index}",
  ]
  ttl = 3600
}
resource "dns_a_record_set" "okd-workers" {
  zone = var.dns_zone
  count = 2
  name = "worker0${count.index+1}.okd"
  addresses = [
    "10.10.0.${23 + count.index}",
  ]
  ttl = 3600
}

resource "dns_a_record_set" "okd-ingress-endpoint" {
  zone = var.dns_zone
  name = "*.tools"
  addresses = ["10.10.0.150"]
  ttl = 3600
}

resource "dns_a_record_set" "okd-api-endpoint" {
  zone = var.dns_zone
  name = "api.okd"
  addresses = ["10.10.0.100"]
  ttl = 3600
}
resource "dns_a_record_set" "okd-api-internal-endpoint" {
  zone = var.dns_zone
  name = "api-int.okd"
  addresses = ["10.10.0.100"]
  ttl = 3600
}
resource "dns_a_record_set" "okd-routes-endpoint" {
  zone = var.dns_zone
  name = "*.apps.okd"
  addresses = ["10.10.0.100"]
  ttl = 3600
}

resource "dns_a_record_set" "vpn" {
  zone = var.dns_zone
  name = "vpn"
  addresses = ["103.4.235.107"]
  ttl = 3600
}
resource "dns_a_record_set" "vps" {
  zone = var.dns_zone
  name = "vps"
  addresses = ["110.232.112.4"]
  ttl = 3600
}


resource "dns_a_record_set" "headscale" {
  zone = var.dns_zone
  name = "headscale"
  addresses = ["103.4.235.107"]
  ttl = 3600
}