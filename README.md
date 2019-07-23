# Private S3 Storage

[![Github Project Stars](https://img.shields.io/github/stars/nolte/personal-storage-infrastructure.svg?label=Stars&style=social)](https://github.com/nolte/personal-storage-infrastructure) [![Travis CI build status](https://travis-ci.org/nolte/personal-storage-infrastructure.svg?branch=master)](https://travis-ci.org/nolte/personal-storage-infrastructure) [![Documentation Status](https://readthedocs.org/projects/personal-storage-infrastructure/badge/?version=latest)](https://personal-storage-infrastructure.readthedocs.io/en/stable/?badge=stable) [![Github Issue Tracking](https://img.shields.io/github/issues-raw/nolte/personal-storage-infrastructure.svg)](https://github.com/nolte/personal-storage-infrastructure) [![Github LatestRelease](https://img.shields.io/github/release/nolte/personal-storage-infrastructure.svg)](https://github.com/nolte/personal-storage-infrastructure)

For hosting a private S3 Object storage we use [min.io](https://min.io/) at [hetzner.cloud](https://docs.hetzner.cloud), created with [Terraform](https://www.terraform.io/docs/providers/hcloud/index.html) and configured with Ansible.

**Precondition**

* For full Configuration you need the Base Scripts from [nolte/ansible_playbook-baseline-online-server](https://github.com/nolte/ansible_playbook-baseline-online-server).
* The Terraform Infrastructuon part used Modules from [nolte/terraform-infrastructure-modules](https://github.com/nolte/terraform-infrastructure-modules).

## Usage

For Interaction with the [Hetzner API](https://docs.hetzner.cloud/), you must be define a environment variable with the name ``HCLOUD_TOKEN``. This Variable will be used from the [Terraform Hetzner Cloud Provider](https://www.terraform.io/docs/providers/hcloud/), and the [hcloud Dynamic Ansible Inventory plugin](https://docs.ansible.com/ansible/latest/plugins/inventory/hcloud.html).

```bash
export HCLOUD_TOKEN=$(pass internet/hetzner.com/projects/personal_storage/token)
```

For the Dependency Management it is recommedet to use a seperated virtual env like:

```bash
virtualenv -p python3 ~/venvs/ansible-vagrant
source ~/venvs/ansible-vagrant/bin/activate
pip install -r requirements.txt
pre-commit install
```

### Infrastructure

The Terraform Source at the `./infrastructure` folder, is splitted into two different Steps.  
Firstly `./infrastructure/longterm_elements` for manage the Hetzner Project and the Storage Volume, so be carefull when you call `terraform destroy`, **you lost all your Stored Data!**  
The second part are located at `./infrastructure/minio_env`, here we attach the Storage volume and create the computing instance. `terraform destory` only delete the Computing Instance! The Storage Volume are not removed, so all your data are safe!  
Both parts used self written Terraform Modules from [nolte/terraform-infrastructure-modules](https://github.com/nolte/terraform-infrastructure-modules) as wrapper for the [Terraform hcloud](https://www.terraform.io/docs/providers/hcloud/index.html) provider.

### Maintenance

For Installation and Maintenance, we use [Ansible](https://www.ansible.com/) with a Dynamic Inventory. We splitted the production used inventory from the playbook Repository. For define the Inventory Location you can use a environment variable ``export ANSIBLE_INVENTORY=$(pwd)/inventory/prod/``, or the ``-i`` parameter. At this Git Repository, you will only find MinIO Specific Configuration steps. For the base configutation we use the [nolte/ansible_playbook-baseline-online-server](https://github.com/nolte/ansible_playbook-baseline-online-server) scripts, like base firewall configruations or install Docker.

For quick usage you can use the [gilt - A GIT layering tool](https://gilt.readthedocs.io/en/latest/) by:

```bash
gilt overlay
```

now you have all required dependencies at the ``./ext_debs`` working directory, and configure the basement with:

```bash
ansible-playbook ./ext_debs/ansible_playbook-baseline-online-server/master-configure-system.yml
```

#### Storage Box Installation

```bash
ansible-playbook maintenance/master-configure-system.yml
```

### Development





*Future Read:*

* [how-to-secure-access-to-minio-server-with-tls](https://docs.min.io/docs/how-to-secure-access-to-minio-server-with-tls.html#using-open-ssl)
* [minio-multi-user-quickstart-guide](https://docs.min.io/docs/minio-multi-user-quickstart-guide.html)
* [minio-client-quickstart-guide](https://docs.min.io/docs/minio-client-quickstart-guide.html)


* [resizing-hetzner-cloud-block-storage-volumes-on-the-fly](https://blog.ruanbekker.com/blog/2018/12/19/resizing-hetzner-cloud-block-storage-volumes-on-the-fly/)
