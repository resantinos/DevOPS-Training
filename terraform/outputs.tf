output "wazuh_server_ip" {
  value = digitalocean_droplet.wazuh_server.ipv4_address
}

output "jenkins_ip" {
  value = digitalocean_droplet.jenkins.ipv4_address
}

output "mysql_db_uri" {
  value = digitalocean_database_cluster.mysql_db.uri
  sensitive = true
}

output "doks_cluster_kubeconfig" {
  value = digitalocean_kubernetes_cluster.doks_cluster.kube_config[0].raw_config
  sensitive = true
}