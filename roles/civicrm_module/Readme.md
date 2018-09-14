## Installs Civcrm on drupal with Drush

This role installs Drush hooks for civcrm and uses them to install civcrm on an existant Drupal installation

### Prerequisites

Requires a working environment of Drupal with Drush globally installed.
Requires a pre-created database for civcrm (may be the same as drupal)

### Variables

* drush_src_url: Url to download drush include file for hooks from
* civicrm_tarfile: Url to download civcrm source tarfile from
* db_host: Server that holds the database 
* db_user: User to access the database
* db_pass: Password to access the database
* encoding: encoding used in the database
* civicrm_db: database name
* destination_dir: Webroot directory
