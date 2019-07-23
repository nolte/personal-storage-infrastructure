variable "private_access_pass_path" {
  default = "private/keyfiles/ssh/private_ed25519/id_ed25519.pub"
}

variable "machine_access_pass_path" {
  default = "private/keyfiles/ssh/ansible_rollout/id_ed25519.pub"
}

variable "minio_storage_runtime_size" {
  default = 30
}
