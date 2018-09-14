## Drupal Modules

This role enables recommended core modules and installs development and backup modules.

## Prerequisites

This role uses Globally installed Drush to make the installation.
This role requires a Drupal installation

### Variables

db_host: host in which database is stored
db_user: database user
db_pass: database passwotd
encoding: encoding used on database
drupal_db: Database name
destination_dir: webroot of the server
drupal_user: Username to the new created Drupal instance
drupal_pass: Password for the username