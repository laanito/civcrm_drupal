## Adds servers in group to known hosts

This role is used to add all newly created servers to known hosts.

### Variables:

* ssh_known_hosts_command: Command to be used to keyscan servers
* ssh_known_hosts_file: In which file should hosts be added
* ssh_known_hosts: Which hosts need to be scanned