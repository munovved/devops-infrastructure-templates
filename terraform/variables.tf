variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
  default     = "b1gxxxxxxxxxxxxxxxxx"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
  default     = "b1gxxxxxxxxxxxxxxxxx"
}

variable "default_zone" {
  type        = string
  description = "Default availability zone"
  default     = "ru-central1-a"
}

variable "cluster_name" {
  type        = string
  description = "Name of the Kubernetes cluster"
  default     = "prod-k8s-cluster"
}
