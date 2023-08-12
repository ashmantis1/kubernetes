provider "dns" {
    update {
        server        = "${var.dns_server}"
        key_name      = "${var.dns_key_name}"
        key_algorithm = "hmac-sha256"
        key_secret    = "${var.dns_key_secret}"
    }
}
resource "dns_a_record_set" "kube-masters" {
  zone = var.dns_zone
  count = length(var.node_ips)
  name = "vault${format("%02d", count.index + 1)}"
  addresses = [
    var.node_ips[count.index]
  ]
  ttl = 3600
}