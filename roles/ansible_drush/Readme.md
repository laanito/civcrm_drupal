## Ansible Drush

*Based on [geerlingguy/ansible-role-drush](https://github.com/geerlingguy/ansible-role-drush)*

Installs Drush, a command line shell and scripting interface for Drupal, on any Linux or UNIX system.

### Requirements:

PHP must be installed

If drush is planned to be installed with composer, composer is required

if drush is going to be installed from git, git is required

### Variables:

* drush_install_path: The location of the entire drush installation (includes all the supporting files, 
as well as the drush executable file.
* drush_path: /usr/local/bin/drush: Where is drush going to be installed

* drush_version:  The version of Drush to install (examples: "8.0.2", "7.x", "7.1.0", "master").
This should be a string as it refers to a git branch, tag, or commit hash.
* drush_prefer_packaged_download: If set to `true`, the role will attempt to install Drush from a downloaded
.phar file. Note that .phar files are only available through later releases of
Drush and will require `drush_version` to be set to `8.0.0-rc3` or higher.
* drush_composer_path: Path where Composer is installed.
* drush_keep_updated: Whether to keep Drush up-to-date with the latest revision of the branch
 specified by drush_version.





