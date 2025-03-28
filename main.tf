terraform {
  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = "~> 0.6.6" # Ensure this matches your provider version
    }
  }
}

provider "harvester" {
  kubeconfig = "/Users/ABONILLA/git/terraform-harvester-ai/harvester-ai.yaml"
}

data "harvester_ssh_key" "abonilla" {
  name      = "abonilla"
  namespace = "default"
}

resource "harvester_virtualmachine" "sles-bulk-vms" {
  name      = "sles-vm-${count.index}"
  namespace = "default"
  count = 25
  cpu    = 1
  memory = "2Gi"

  network_interface {
    name          = "nic-1"
    #network_name  = "default/vlan1" # Change this to match your network
    wait_for_lease = true
  }

  disk {
    name      = "disk-1"
    type      = "disk"
    size      = "20Gi"
    bus       = "virtio"
    boot_order  = 1
    image = "default/image-rvjcv" # Change this to match your Harvester image
  }

  ssh_keys = [
    data.harvester_ssh_key.abonilla.id
  ]

  cloudinit {
    user_data = <<-EOF
      #cloud-config
      users:
        - name: abonilla
          sudo: 'ALL=(ALL) NOPASSWD:ALL'
          lock_passwd: false
          shell: /bin/bash
          plain_text_passwd: password
          ssh_authorized_keys:
            - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC468mc3UcW5P7HJXuB10HyQOIVqj6/6xXORAagj0X8fkAV4s999iPyUDu59w9dLMQ3NiltRjzUs8BHGRvDbZC8yICNtx9mrZEpj3vAdkzEEZLlLQWHPuE60y9+SzF0p9ldePOUeqkYjgVhifOf/OT09FvK3h92EsOfulUqMvGPKEabgn+9RdeKhBAmXr1ea+CpjbTkcniQ2vGc8zuzOjmcUnpDU4N1wqw7ZlpgmIYG4C6d2f8Hg9MsQ687bhrzxxh/j5EyHVXCEWOnpvE/Y2vnNcDf77IwdeOTQ1NF5rFv/QaqERPyZe8FNpod7zGHXWxXlMtRmoQ05RxVG8VeRVal4/vAuMe6ZeHWtPaFHhyMWB7JHiJdBo/3rWGx11N7wQok3wyHi+xAKcnk6+LDp0mWkC2zqBm/WWUIgAr1r4LODnkgi+vc0ISnUedCexqARfhPiB+UMbmzJyATLSJ65dl2JxZbbQHigWbYdpXElo3hnfsENtEFQ9ol4TyRw6/mK8M= abonilla@Alejandros-MacBook-Pro.local
      EOF
  }
}
resource "harvester_virtualmachine" "ubuntu-bulk-vms" {
  name      = "ubuntu-vm-${count.index}"
  namespace = "default"
  count = 25
  cpu    = 1
  memory = "2Gi"

  network_interface {
    name          = "nic-1"
#    network_name  = "default/vlan1" # Change this to match your network
    wait_for_lease = true
  }

  disk {
    name      = "disk-1"
    type      = "disk"
    size      = "20Gi"
    bus       = "virtio"
    boot_order  = 1
    image = "default/image-24wbx" # Change this to match your Harvester image
  }

  ssh_keys = [
    data.harvester_ssh_key.abonilla.id
  ]

  cloudinit {
    user_data = <<-EOF
      #cloud-config
      users:
        - name: abonilla
          sudo: 'ALL=(ALL) NOPASSWD:ALL'
          lock_passwd: false
          shell: /bin/bash
          plain_text_passwd: password
          ssh_authorized_keys:
            - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC468mc3UcW5P7HJXuB10HyQOIVqj6/6xXORAagj0X8fkAV4s999iPyUDu59w9dLMQ3NiltRjzUs8BHGRvDbZC8yICNtx9mrZEpj3vAdkzEEZLlLQWHPuE60y9+SzF0p9ldePOUeqkYjgVhifOf/OT09FvK3h92EsOfulUqMvGPKEabgn+9RdeKhBAmXr1ea+CpjbTkcniQ2vGc8zuzOjmcUnpDU4N1wqw7ZlpgmIYG4C6d2f8Hg9MsQ687bhrzxxh/j5EyHVXCEWOnpvE/Y2vnNcDf77IwdeOTQ1NF5rFv/QaqERPyZe8FNpod7zGHXWxXlMtRmoQ05RxVG8VeRVal4/vAuMe6ZeHWtPaFHhyMWB7JHiJdBo/3rWGx11N7wQok3wyHi+xAKcnk6+LDp0mWkC2zqBm/WWUIgAr1r4LODnkgi+vc0ISnUedCexqARfhPiB+UMbmzJyATLSJ65dl2JxZbbQHigWbYdpXElo3hnfsENtEFQ9ol4TyRw6/mK8M= abonilla@Alejandros-MacBook-Pro.local
      EOF
  }
}
