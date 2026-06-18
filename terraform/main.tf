resource "yandex_vpc_network" "k8s_network" {
  name = "k8s-network"
}

resource "yandex_vpc_subnet" "k8s_subnet" {
  name           = "k8s-subnet-a"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.k8s_network.id
  v4_cidr_blocks = ["10.10.10.0/24"]
}

resource "yandex_iam_service_account" "k8s_sa" {
  name        = "k8s-sa"
  description = "Service account for K8s cluster management"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_sa.id}"
}

resource "yandex_kubernetes_cluster" "k8s_cluster" {
  name       = var.cluster_name
  network_id = yandex_vpc_network.k8s_network.id

  master {
    version = "1.28"
    zonal {
      zone      = yandex_vpc_subnet.k8s_subnet.zone
      subnet_id = yandex_vpc_subnet.k8s_subnet.id
    }
    public_ip = true
  }

  service_account_id      = yandex_iam_service_account.k8s_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_sa.id

  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_editor
  ]
}

resource "yandex_kubernetes_node_group" "gpu_nodes" {
  cluster_id = yandex_kubernetes_cluster.k8s_cluster.id
  name       = "gpu-node-group"
  version    = "1.28"

  instance_template {
    platform_id = "gpu-standard-v3" # Платформа с поддержкой GPU NVIDIA

    resources {
      cores  = 8
      memory = 32
      gpus   = 1
    }

    boot_disk {
      type = "network-ssd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    network_interface {
      nat        = true
      subnet_ids = [yandex_vpc_subnet.k8s_subnet.id]
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = var.default_zone
    }
  }
}
