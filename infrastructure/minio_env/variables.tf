variable "minio_computing_instance_name" {
  default = "storagenode"
}

variable "minio_computing_instance_service_label" {
  default = "storagebox"
}

variable "minio_storage_docker_active" {
  default = true
}

variable "minio_storage_logs_active" {
  default = false
}

variable "minio_computing_instance_labels" {
  type = "map"
  default = {
    stage = "dev"
    state = "active"
  }
}
