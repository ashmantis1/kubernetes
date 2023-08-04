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
  count = length(var.master_ips)
  name = "master${format("%02d", count.index + 1)}.${var.cluster_name}"
  addresses = [
    var.master_ips[count.index]
  ]
  ttl = 3600
}
resource "dns_a_record_set" "kube-workers" {
  zone = var.dns_zone
  count = length(var.worker_ips)
  name = "worker${format("%02d", count.index + 1)}.${var.cluster_name}"
  addresses = [
    var.worker_ips[count.index]
  ]
  ttl = 3600
}

resource "dns_a_record_set" "api-endpoint" {
  zone = var.dns_zone
  name = "api.${var.cluster_name}"
  addresses = [
    var.api_ip
  ]
  ttl = 3600
}
