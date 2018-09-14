## Installs git on server
Based on [Ansible Role: Git](https://github.com/geerlingguy/ansible-role-git)

Installs Git, a distributed version control system, on any RHEL/CentOS or Debian/Ubuntu Linux system.

### Requirements:

No previouos requirements

### Variables

* git_enablerepo: Repository to be used to get packets from
* git_packages: Packages to install
* git_install_from_source: If set to TRUE, git will be installed from source
* git_install_path: Path where git will be installed
* git_version: Version to install from source
* git_install_from_source_force_update: Whenever installation must be forced if older version is installed
* git_reinstall_from_source: Reinstall from source if already installed

