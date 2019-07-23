================================
Usermanagement
================================

For Administration Tasks you can use the `MinIO Admin <https://docs.min.io/docs/minio-admin-complete-guide.html>`_ Tool.


.. code-block:: bash
    :caption: configure mc admin tool
    :name: example-mc-configure

    export HCLOUD_TOKEN=$(pass internet/hetzner.com/projects/personal_storage/token) && \
    export STORAGE_NODE_ENDPOINT=$(curl -s -H "Authorization: Bearer $HCLOUD_TOKEN" 'https://api.hetzner.cloud/v1/servers?name=storagenode' | jq -r '.servers[0].public_net.ipv4.dns_ptr') && \
        mc config host add mystoragebox \
        https://$STORAGE_NODE_ENDPOINT \
        $(pass internet/project/mystoragebox/minio_access_key) \
        $(pass internet/project/mystoragebox/minio_secret_key)


.. code-block:: bash
    :caption: check mc admin tool
    :name: example-mc-check-config

    mc admin info mystoragebox


Bucket Policy
---------------------------------

The `MinIO <https://min.io/>`_ Bucket Policies ar AWS Compatible.

.. code-block:: json
    :caption: Simple Policy
    :name: example-s3-policy-simple

    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:GetBucketLocation",
                    "s3:ListBucket"
                ],
                "Resource": "arn:aws:s3:::backup"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:DeleteObject",
                    "s3:GetObject",
                    "s3:PutObject"
                ],
                "Resource": "arn:aws:s3:::backup/*"
            }
        ]
    }


*Additional Links:*

* `Bucket Policy <https://gist.github.com/krishnasrinivas/2f5a9affe6be6aff42fe723f02c86d6a>`_
* `AWS Bucket Doku <https://docs.aws.amazon.com/AmazonS3/latest/user-guide/add-bucket-policy.html>`_
* `AWS example bucket policies <https://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html>`_

.. code-block:: bash
    :caption: create a policy
    :name: example-s3-create-policy

    mc admin policy add mystoragebox backup_policy test.json


Access Keys
---------------------------------

.. code-block:: bash
    :caption: Create A User
    :name: example-minio-create-user

    new_user=backupuser \
        && pass generate -n internet/project/mystoragebox/users/${new_user}/minio_access_key 25 \
        && pass generate internet/project/mystoragebox/users/${new_user}/minio_secret_key 45 \
        && mc admin user add mystoragebox \
            $(pass internet/project/mystoragebox/users/${new_user}/minio_access_key) \
            $(pass internet/project/mystoragebox/users/${new_user}/minio_secret_key) \
            backup_policy


.. code-block:: bash
    :caption: Remove existing User
    :name: example-minio-delete-user

    mc admin user remove mystoragebox $(pass internet/project/mystoragebox/users/${new_user}/minio_access_key)
