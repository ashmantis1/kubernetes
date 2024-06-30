provider "dns" {
    update {
        server        = "${var.dns_server}"
        key_name      = "${var.dns_key_name}"
        key_algorithm = "hmac-sha256"
        key_secret    = "${var.dns_key_secret}"
    }
}
resource "dns_a_record_set" "freeipa-masters" {
  zone = "${var.dns_zone}."
  count = length(var.node_ips)
  name = "${var.service_name}${format("%02d", count.index + 1)}"
  addresses = [
    var.node_ips[count.index]
  ]
  ttl = 3600
}

resource "dns_ptr_record" "freeipa-masters" {
  count = length(var.node_ips)
  zone = "${var.reverse_zone}."
  ptr = "${var.service_name}${format("%02d", count.index + 1)}.${var.dns_zone}."
  name = "${format("%s.%s",
      element(split(".", element(
        var.node_ips, count.index
      )), 3),
      element(split(".", element(
        var.node_ips, count.index
      )), 2)
    )
  }"
  ttl = 3600
}