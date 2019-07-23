locals {
  static_service_labels = {
    service = "${var.minio_computing_instance_service_label}"
  }
}

module "minio_storage_docker" {
  source         = "git::https://github.com/nolte/terraform-infrastructure-modules.git//storage_elements?ref=v0.0.1"
  storage_active = "${var.minio_storage_docker_active}"
  storage_name   = "minio_storage_docker"
  storage_format = "ext4"
  storage_labels = {
    service = "${var.minio_computing_instance_service_label}"
    type    = "docker"
  }
}

module "minio_storage_logs" {
  source         = "git::https://github.com/nolte/terraform-infrastructure-modules.git//storage_elements?ref=v0.0.1"
  storage_active = "${var.minio_storage_logs_active}"
  storage_name   = "minio_storage_logs"
  storage_format = "ext4"
  storage_labels = {
    service = "${var.minio_computing_instance_service_label}"
    type    = "logging"
  }
}

data "hcloud_volume" "minio_storage_runtime" {
  with_selector = "service==${var.minio_computing_instance_service_label},type=runtime_storage"
}

data "hcloud_ssh_key" "machine_key" {
  with_selector = "usage=machine"
}

data "hcloud_ssh_key" "private_key" {
  with_selector = "usage=manual"
}

data "template_file" "cloudinit_mounts" {
  template = "${file("${path.module}/cloudinit_templates/cloudinit mounts.yml.tp")}"

  vars = {
    runtime_storage_device_id = "${data.hcloud_volume.minio_storage_runtime.linux_device}"
    runtime_storage_path      = "/mnt/minio/data"
    runtime_storage_type      = "xfs"

    docker_storage_device_id = "${var.minio_storage_docker_active == true ? module.minio_storage_docker.storage_volume_linux_device : 0}"
    docker_storage_path      = "/var/lib/docker"
    docker_storage_type      = "${var.minio_storage_docker_active == true ? module.minio_storage_docker.storage_volume_format : 0}"
    docker_storage_active    = "${var.minio_storage_docker_active}"

    logs_storage_device_id = "${var.minio_storage_logs_active == true ? module.minio_storage_logs.storage_volume_linux_device : 0}"
    logs_storage_path      = "/var/logs"
    logs_storage_type      = "${var.minio_storage_logs_active == true ? module.minio_storage_logs.storage_volume_format : 0}"
    logs_storage_active    = "${var.minio_storage_logs_active}"

  }
}

locals {
  merged_minio_computing_instance_labels = "${merge(var.minio_computing_instance_labels, local.static_service_labels)}"
}

module "minio_computing_elements" {
  source                                           = "git::https://github.com/nolte/terraform-infrastructure-modules.git//computing_elements?ref=v0.0.1"
  computing_instance_name                          = "${var.minio_computing_instance_name}"
  computing_instance_usage_root_key                = "${data.hcloud_ssh_key.machine_key.id}"
  computing_instance_labels                        = "${local.merged_minio_computing_instance_labels}"
  computing_instance_ssh_machine_key_id_var        = "${data.hcloud_ssh_key.machine_key.public_key}"
  computing_instance_ssh_private_key_id_var        = "${data.hcloud_ssh_key.private_key.public_key}"
  computing_instance_additional_volumes_cloud_init = "${data.template_file.cloudinit_mounts.rendered}"
}

resource "hcloud_volume_attachment" "minio_computing_volume_runtime" {
  volume_id = "${data.hcloud_volume.minio_storage_runtime.id}"
  server_id = "${module.minio_computing_elements.computing_instance_id}"
  automount = true
}


resource "hcloud_volume_attachment" "minio_computing_volume_docker" {
  count     = "${var.minio_storage_docker_active == true ? 1 : 0}"
  volume_id = "${module.minio_storage_docker.storage_volume_id}"
  server_id = "${module.minio_computing_elements.computing_instance_id}"
  automount = true
}


resource "hcloud_volume_attachment" "minio_computing_volume_logging" {
  count     = "${var.minio_storage_logs_active == true ? 1 : 0}"
  volume_id = "${module.minio_storage_logs.storage_volume_id}"
  server_id = "${module.minio_computing_elements.computing_instance_id}"
  automount = true
}
