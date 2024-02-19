# Main Configuration: main.tf

# Wazuh and Ansible Server Droplet
resource "digitalocean_droplet" "wazuh_server" {
  name   = "wazuh-server"
  size   = "s-2vcpu-4gb"
  image  = "ubuntu-22-04-x64"
  region = "ams3"
  ssh_keys = [data.digitalocean_ssh_key.default.id]
}

# Jenkins CI/CD Droplet
resource "digitalocean_droplet" "jenkins" {
  name   = "jenkins"
  size   = "s-2vcpu-4gb"
  image  = "ubuntu-22-04-x64"
  region = "ams3"
  ssh_keys = [data.digitalocean_ssh_key.default.id]
}

# Managed MySQL Database
resource "digitalocean_database_cluster" "mysql_db" {
  name       = "mysql-cluster"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-2gb"
  region     = "ams3"
  node_count = 1
}

# DOKS Cluster
resource "digitalocean_kubernetes_cluster" "doks_cluster" {
  name    = "doks-cluster"
  region  = "ams3"
  version = "latest"

  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-2gb"
    node_count = 1
  }
}