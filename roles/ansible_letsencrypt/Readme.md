## Generate certificates on server
Based on [Ansible Role: Letsencrypt](https://github.com/thefinn93/ansible-letsencrypt)

An ansible role to generate TLS certificates and get them signed by Let's Encrypt.

### Requirements:

No previous requirements

### Variables


* letsencrypt_src_directory: Directory of letsencrypt
* letsencrypt_venv: Environment Directory
* letsencrypt_cert_domains: Domains which will get certificate generated
* letsencrypt_webroot_path:  Path of webroot to verify cert
* letsencrypt_authenticator: authenticator method to be used
* letsencrypt_email: "account email to be used"
* letsencrypt_path: path to letsencrypt
* letsencrypt_command: Command line to be used
* letsencrypt_renewal_frequency: How often cert should be renewed
* letsencrypt_renewal_command_args: Extra args for renewal
* letsencrypt_standalone_command_args: Extra args for standalone command
* letsencrypt_server: Staging or test server to be used by letsencrypt
