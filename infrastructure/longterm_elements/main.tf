module "private_access_key" {
  source = "git::https://github.com/nolte/terraform-infrastructure-modules.git//project_access_elements?ref=v0.0.1"

  name      = "private_access"
  pass_path = "${var.private_access_pass_path}"
  labels = {
    usage = "manual"
  }
}

module "management_access_key" {
  source    = "git::https://github.com/nolte/terraform-infrastructure-modules.git//project_access_elements?ref=v0.0.1"
  name      = "management_key"
  pass_path = "${var.machine_access_pass_path}"
  labels = {
    usage = "machine"
  }
}
module "minio_storage_runtime" {
  source       = "git::https://github.com/nolte/terraform-infrastructure-modules.git//storage_elements?ref=v0.0.1"
  storage_name = "minio_storage_runtime"
  storage_size = "${var.minio_storage_runtime_size}"
  storage_labels = {
    service = "storagebox"
    type    = "runtime_storage"
  }
}
