# Compucorp Test

## Objectives:

The main target of this code is deploying a CiviCRM app on an EC2 instance on Amazon.

## Prerequisites:

AMI Credentials with privileges to create all AWS components

## Summary:

This task incluye several playbooks that can be run one by one or all at once, also includes a Dockerfile to create a Docker image with all the requisites to run Ansible tasks.
Every role is commented on its own folder.

### Components:

1. *Dockerfile*.- Creates a Ubuntu Bionic image with all the packages needed to run Ansible.
2. *run_tasks.yml*.- Can be used as main playbook, includes imports to all the created playbooks.
3. *create_instances.yml*.- Creates AWS VPC, Subnets and EC2 instances, also generates the keys needed to access instances.
4. *prepare_servers.yml*.- Add servers to known hosts to avoid ssh issues. Create ansible user, grant sudo privileges and installs python on remote servers.
5. *deploy_nginx.yml*.- Deploy basic NGINX configuration, this is needed in order to create ELB on next playbook.
6. *create_elb_rds.yml*.- Adds RDS instances and ELB
7. *deploy_php.yml*.- Installs needed php packages
8. *deploy_git_yml*.- Installs git on webservers
9. *deploy_drush.yml*.- Installs drush globally on servers
10. *deploy_databases.yml*.- Installs required packages and databases for Drupal and CiviCRM
11. *deploy_drupal.yml*.- Makes basic Drupal installation
12. *deploy_modules.yml*.- Installs additional modules in drupal
13. *configure_nginx.yml*.- Configures Nginx to serve installed Drupal
14. *deploy_civicrm.yml*.- Installs CiviCRM on server using Drush integration
15. *civcrm_tweaks.yml*.- Provides extra configuration to CiviCRM (views integration and extensions directory)
16. *deploy_letsencrypt.yml*.- Generates letsencrypt certificate on servers
17. *sync_servers.yml*.- Not intended to be used when only one server is deployed, this playbook syncs webservers web folders

## Usage:

The recommended way to use it is creating a Docker container and using it as the manager node, running all playbooks from this node.
Once container is created, AMI credentials must be added to user environment for it to work.

Best way to run it is running the *create_instances* playbook first and all the rest on a second batch using the newly created inventory so it can be verified all AWS components are correctly created.

## Accessing created machines

On .ssh folder there are the credentials used by ansrunner user, they can be used to ssh into the EC2 instances


## Common variables:

All common variables are set on *secret_vars/secret.yml* this script is intended to be crypted with ansible vault if the managing node is on a production environment

*create_instances.yml* generates a new file for each environment deployed with AWS IDs of the components.

### Variables:

#### Environment variables:

* COMPANY: Company Name
* ENVIRONMENT: Environment name
* SERVER_ROLE: Role of the servers on the environment

#### VPC specific variables
* VPC_NAME: Name to be given to newly created VPC
* VPC_REGION: AWS Region where VPC will be created
* VPC_CIDR: CIDR assigned to VPC
* VPC_CLASS_DEFAULT: Default class used in subnets

#### Details for creating EC2 KEY Pair
* GITHUB_USERNAME: In case Github key is used
* EC2_KEY_NAME: Name given to the newly created key
* LOCAL_USER_SSH_KEY: yes (if not Github key is used)

#### Ubuntu AMI specific variables
* AMI_NAME: "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
* AMI_OWNER: "679593333241"

(This one is Official Ubuntu Bionic)

#### EC2 instances specific variables
* EC2_INSTANCE_TYPE: instance type to be used
* EC2_SECURITY_GROUP_NAME: Name of SG
* EC2_VOLUME_SIZE: Volume size assigned to EC2
* EC2_COUNT: Number of EC2 created on each EC2 subnet
* EC2_SUBNET_ID: Subnets in which EC2 instances will be created, it will create EC2_COUNT instances on each subnet

#### RDS specific variables
* RDS_SUBNET_GROUP_NAME: Name given yo RDS Group
* RDS_SG_DESCRIPTION: Description given to SG
* RDS_SG_SUBNETS: Subnets to be added to RDS SG
* RDS_SG_NAME: Name given to RDS SG
* RDS_MULTI_ZONE_OPTION: Whenever it shoud use Multizone RDS option or not
* RDS_INSTANCE_NAME: Name given to RDS instance
* RDS_DB_ENGINE: DBEngine to be usde
* RDS_DB_SIZE: Size assigned to RDS instance
* RDS_DB_NAME: Name of newly created database, only used to administative login
* RDS_INSTANCE_TYPE: Instance type
* RDS_DB_USERNAME: Username to be created on RDS
* RDS_DB_PASSWORD: Passwotd assigned
* RDS_BACKUP_RETENTION_PERIOD: 1
* RDS_PUBLICLY_ACCESSIBLE: Whenever RDS is public or no
* RDS_WAIT_TIMEOUT: 1800

#### Elastic Load Balancer specific variables
* ELB_NAME: Name given to ELB
* ELB_SUBNET_ID: Subnets assigned to ELB
* PUBLIC_URL: Public side of the ELB
* ELB_PURGE_SUBNETS: Whenever subnets should be purged on run
* ELB_CROSS_AZ_LOAD_BALANCING: Allow load balance betweeb zones
* ELB_PING_PROTOCOL: Protocol used for health checks
* ELB_PING_PORT: port used for health checks
* ELB_RESPONSE_TIMEOUT: Timeout
* ELB_INTERVAL: Interval of health checks
* ELB_UNHEALTHY_THRESHOLD: How many check should fail to mark the instance as unhealthy
* ELB_HEALTHY_THRESHOLD: How many checks to mark instance as healthy again
* ELB_CONNECTION_DRAINING_TIMEOUT: 300
* ELB_SECURITY_GROUP_NAME: Name given to SG
* ELB_STICKINESS_TYPE: How should stick seasons be handled
* ELB_STICKINESS_ENABLED: is stickiness active?
* ELB_STICKINESS_EXPIRATION: Time until session stickyness is expired
* ELB_LISTENERS: Defines which requests will be answered and how
#### EC2 Security Groups specific variables 
* WEB_SG_NAME: Name of Web SG
* DATABASE_SG_NAME: Name of RDS SG
* SSH_SG_NAME: Name of ssh SG
* ELB_SG_NAME: Name of ELB SG

#### Security Groups
* EC2_SECURITY_GROUPS: SG Definition (array with all active SGs)

#### Secrity Groups info(Name, Description and Rules) for Web, RDS and ELB

One array for each SG to be created

#### Drupal options:
* DRUPAL_USER: Name of the user to be created on Drupal instace
* DRUPAL_PASS:Password to be assigned to user