==========================================
Glossary
==========================================

.. glossary::

  Terraform
    With `Terraform <https://terraform.io>`_ we Create the Infrastructure like Volumes, FloatingIP and Virtual Machines.
    For the Hetzner Intergration wie use the `hcloud provider <https://www.terraform.io/docs/providers/hcloud/>`_

  Ansible
    `Ansible <https://ansible.com>`_ is used for System configuration.

  restic
    `restic <https://restic.net/>`_ is a backup tool.

  Vagrant
    `Vagrant <https://www.vagrantup.com>`_, is used for the local Environment.

  logrotate
    Remove old, and rotate the  logs with `logrotate <https://linux.die.net/man/8/logrotate>`_.

  fail2ban
    Usig `fail2ban <https://www.fail2ban.org/wiki/index.php/Main_Page>`_ for block brute force attacks.

  Extra Packages for Enterprise Linux
    The `EPEL <https://fedoraproject.org/wiki/About_EPEL>`_ repository is used for install extra packages like :term:`restic`.

  Open JDK
    Java JDK

  pass
    The Commandline based `passwordstore <https://www.passwordstore.org/>`_, can integrated to :term:`Ansible <pass ansible plugin>` and :term:`Terraform <pass Terraform Provider>`,

  pass ansible plugin
    Used for Secrets lookups `passwordstore plugin <https://docs.ansible.com/ansible/latest/plugins/lookup/passwordstore.html>`_

  pass Terraform Provider
    For combinate :term:`Terraform` and :term:`pass` we use the custom provider `camptocamp/terraform-provider-pass <https://github.com/camptocamp/terraform-provider-pass>`_.

  Ansile Master Playbooks
    `importing-playbooks <https://docs.ansible.com/ansible/2.4/playbooks_reuse_includes.html#importing-playbooks>`_

  Hetzner Cloud
    `Hetzner Cloud <https://www.hetzner.de/cloud>`_

  firewall
    hier wird der klassiker FirewallD verwendet.

  Advanced Intrusion Detection Environment (`aide`_)
    Store file see `install-aide-centos-7 <https://linoxide.com/monitoring-2/install-aide-centos-7/>`_. *(umsetzung offen)*

  OpenSCAP
    System vulnerability scans, see (`open-scap`_)

  Sphinx
    `Sphinx <http://www.sphinx-doc.org/en/master/>`_, is a tool that makes it easy to create documentation

  reStructuredText
    `reStructuredText <http://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html>`_ Markdown alternative.

  Molecule
    `Molecule <https://molecule.readthedocs.io/en/stable/>`_ used for automatical Ansible Tests.

  Testinfra
    `Testinfra <https://testinfra.readthedocs.io/en/latest/>`_ Testing infrastructure with Ansible and Pytest.

  Virtualenv
    `Virtualenv <https://virtualenv.pypa.io/en/latest/>`_ create isolated Python environments.


.. _aide: https://de.wikipedia.org/wiki/Advanced_Intrusion_Detection_Environment
.. _open-scap: https://www.open-scap.org/tools/openscap-base/#documentation
.. _wiki_scap: https://de.wikipedia.org/wiki/Security_Content_Automation_Protocol
