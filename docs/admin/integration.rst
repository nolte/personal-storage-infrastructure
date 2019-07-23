================================
Integrate
================================

A S3 Object Storage can be used for different Use Cases, like Archive Backups or share the Terraform State File.

Terraform State File
--------------------------------

For a remote State file you can use the `S3 backend Type <https://www.terraform.io/docs/backends/types/s3.html>`_.

.. code-block:: json
    :caption: Export Required Envs
    :name: example-s3-policy-simple

    export HCLOUD_TOKEN=$(pass internet/hetzner.com/projects/personal_storage/token) && \
      export AWS_ACCESS_KEY_ID=$(pass internet/project/mystoragebox/minio_access_key) && \
      export AWS_SECRET_ACCESS_KEY=$(pass internet/project/mystoragebox/minio_secret_key) && \
      export AWS_S3_ENDPOINT=https://$(curl -s -H "Authorization: Bearer $HCLOUD_TOKEN" 'https://api.hetzner.cloud/v1/servers?name=storagenode' | jq -r '.servers[0].public_net.ipv4.dns_ptr')




.. code-block:: terraform
    :caption: Terraform State File Provider
    :name: example-terraform-s3-state-file

    terraform {
      backend "s3" {
        key                         = "minecraft/productuion/project"
        region                      = "main"
        bucket                      = "terraform-states"
        skip_requesting_account_id  = true
        skip_credentials_validation = true
        skip_get_ec2_platforms      = true
        skip_metadata_api_check     = true
        skip_region_validation      = true
        force_path_style            = true
      }
    }

Restic Backups
--------------------------------

For Backups with :term:`restic` can use a `s3 repository <https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html#minio-server>`_, so you have a central storage for restoring and archiving.

.. code-block:: bash
    :caption: list existing snapshots
    :name: example-restic-list-snapshots

    export HCLOUD_TOKEN=$(pass internet/hetzner.com/projects/personal_storage/token) && \
      export AWS_ACCESS_KEY_ID=$(pass internet/project/mystoragebox/minio_access_key) && \
      export AWS_SECRET_ACCESS_KEY=$(pass internet/project/mystoragebox/minio_secret_key) && \
      export RESTIC_PASSWORD=$(pass internet/project/minecraft/backups/restic_password) && \
      export RESTIC_REPOSITORY=s3:https://$(curl -s -H "Authorization: Bearer $HCLOUD_TOKEN" 'https://api.hetzner.cloud/v1/servers?name=storagenode' | jq -r '.servers[0].public_net.ipv4.dns_ptr')/backup/minecraft-production/restic/gamedata && \
      restic snapshots
