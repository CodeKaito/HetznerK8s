resource "hcloud_server" "kube-master" {
  name = "kube-master"
  image = "rocky-9" #
  server_type = "cx21"
  datacenter  = "hel1-dc2"
  ssh_keys = [ "id_extraordy_challenge" ]

  network {
    network_id = hcloud_network.kubernetes-node-network.id
    ip         = "172.16.0.120"
  }

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  depends_on = [
    hcloud_network_subnet.kubernetes-node-subnet
  ]

}

resource "hcloud_server" "kube-worker" {
  count       = 2
  name        = "kube-worker-${count.index + 1}"
  image       = "rocky-9"
  server_type = "cx21"
  datacenter  = "hel1-dc2"
  ssh_keys = [ "id_extraordy_challenge" ]

  network {
    network_id = hcloud_network.kubernetes-node-network.id
    ip         = "172.16.0.12${count.index + 1}"
  }

}