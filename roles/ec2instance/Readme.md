## Creates EC2 instance on AWS

Searches for required AMI and creates "EC2_COUNT" EC2 instances on each network on the provided VPC
Adds the newly created machines to hosts file inventory

### Prerequisites

Requires created VPC and at least one created subnet with security groups defined and security key created

### Variables

* ENVIRONMENT: Environment name, used for identification
* SERVER_ROLE: server role, used for identification
* vpc_name: Name of the VPC in which instances will be created
* vpc_region: Region in which VPC is created
* ec2_instance_type: Type of EC2 instances to be created
* ec2_key_name: Name of the key to be used
* ec2_security_group_name: Name of the security group to be applied
* ec2_volume_size: Size of the volume attached to each EC2
* ec2_count: Number of EC2 instances to be spawned on each subnet
* ec2_subnet_id: ID of the subnets in which instances will be spawned