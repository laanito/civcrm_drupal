## Installs php on server
Based on [Ansible Role: geerlingguy/ansible-role-php](https://github.com/geerlingguy/ansible-role-php)

Installs PHP on RedHat/CentOS and Debian/Ubuntu servers..

### Requirements:

No previous requirements

### Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    php_packages: []

A list of the PHP packages to install (OS-specific by default). You'll likely want to install common packages like `php`, `php-cli`, `php-devel` and `php-pdo`, and you can add in whatever other packages you'd like (for example, `php-gd` for image manipulation, or `php-ldap` if you need to connect to an LDAP server for authentication).

_Note: If you're using Debian/Ubuntu, you also need to install `libapache2-mod-fastcgi` (for cgi/PHP-FPM) or `libapache2-mod-php7.0` (or a similar package depending on PHP version) if you want to use `mod_php` with Apache._

    php_packages_extra: []

A list of extra PHP packages to install without overriding the default list.

    php_enable_webserver: true

If your usage of PHP is tied to a web server (e.g. Apache or Nginx), leave this default value. If you are using PHP server-side or to run some small application, set this value to `false` so this role doesn't attempt to interact with a web server.

    php_webserver_daemon: "httpd"

The default values for the HTTP server deamon are `httpd` (used by Apache) for RedHat/CentOS, or `apache2` (also used by Apache) for Debian/Ubuntu. If you are running another webserver (for example, `nginx`), change this value to the name of the daemon under which the webserver runs.

    php_enablerepo: ""

(RedHat/CentOS only) If you have enabled any additional repositories (might I suggest [geerlingguy.repo-epel](https://github.com/geerlingguy/ansible-role-repo-epel) or [geerlingguy.repo-remi](https://github.com/geerlingguy/ansible-role-repo-remi)), those repositories can be listed under this variable (e.g. `remi-php70,epel`). This can be handy, as an example, if you want to install the latest version of PHP 7.0, which is in the Remi repository.

    php_packages_state: "present"

If you have enabled any additional repositories such as [geerlingguy.repo-epel](https://github.com/geerlingguy/ansible-role-repo-epel) or [geerlingguy.repo-remi](https://github.com/geerlingguy/ansible-role-repo-remi), you may want an easy way to swap PHP versions on the fly. By default, this is set to `"present"`. You can override this variable to `"latest"` to upgrade to the latest available version. Combined with php_enablerepo`, a user now doesn't need to manually uninstall the existing PHP packages before installing them from a different repository.

You can also use the [`geerlingguy.php-versions`](https://galaxy.ansible.com/geerlingguy/php-versions/) role to more easily switch between major PHP versions (e.g. 5.6, 7.0, 7.1, 7.2).

    php_install_recommends: yes

(Debian/Ubuntu only) Whether to install recommended packages when installing `php_packages`; you might want to set this to `no` explicitly if you're installing a PPA that recommends certain packages you don't want (e.g. Ondrej's `php` PPA will install `php7.0-cli` if you install `php-pear` alongside `php5.6-cli`... which is often not desired!).

    php_executable: "php"

The executable to run when calling PHP from the command line. You should only change this if running `php` on your server doesn't target the correct executable, or if you're using software collections on RHEL/CentOS and need to target a different version of PHP.

### PHP-FPM

PHP-FPM is a simple and robust FastCGI Process Manager for PHP. It can dramatically ease scaling of PHP apps and is the normal way of running PHP-based sites and apps when using a webserver like Nginx (though it can be used with other webservers just as easily).

When using this role with PHP running as `php-fpm` instead of as a process inside a webserver (e.g. Apache's `mod_php`), you need to set the following variable to `true`:

    php_enable_php_fpm: false

If you're using Apache, you can easily get it configured to work with PHP-FPM using the [geerlingguy.apache-php-fpm](https://github.com/geerlingguy/ansible-role-apache-php-fpm) role.

    php_fpm_listen: "127.0.0.1:9000"
    php_fpm_listen_allowed_clients: "127.0.0.1"
    php_fpm_pm_max_children: 50
    php_fpm_pm_start_servers: 5
    php_fpm_pm_min_spare_servers: 5
    php_fpm_pm_max_spare_servers: 5

Specific settings inside the default `www.conf` PHP-FPM pool. If you'd like to manage additional settings, you can do so either by replacing the file with your own template or using `lineinfile` like this role does inside `tasks/configure-fpm.yml`.

### php.ini settings

    php_use_managed_ini: true

By default, all the extra defaults below are applied through the php.ini included with this role. You can self-manage your php.ini file (if you need more flexility in its configuration) by setting this to `false` (in which case all the below variables will be ignored).

    php_memory_limit: "256M"
    php_max_execution_time: "60"
    php_max_input_time: "60"
    php_max_input_vars: "1000"
    php_realpath_cache_size: "32K"
    php_file_uploads: "On"
    php_upload_max_filesize: "64M"
    php_max_file_uploads: "20"
    php_post_max_size: "32M"
    php_date_timezone: "America/Chicago"
    php_allow_url_fopen: "On"
    php_sendmail_path: "/usr/sbin/sendmail -t -i"
    php_output_buffering: "4096"
    php_short_open_tag: false
    php_error_reporting: "E_ALL & ~E_DEPRECATED & ~E_STRICT"
    php_display_errors: "Off"
    php_display_startup_errors: "On"
    php_expose_php: "On"
    php_session_cookie_lifetime: 0
    php_session_gc_probability: 1
    php_session_gc_divisor: 1000
    php_session_gc_maxlifetime: 1440
    php_session_save_handler: files
    php_session_save_path: ''
    php_disable_functions: []

Various defaults for PHP. Only used if `php_use_managed_ini` is set to `true`.

### OpCache-related Variables

The OpCache is included in PHP starting in version 5.5, and the following variables will only take effect if the version of PHP you have installed is 5.5 or greater.

    php_opcache_zend_extension: "opcache.so"
    php_opcache_enable: "1"
    php_opcache_enable_cli: "0"
    php_opcache_memory_consumption: "96"
    php_opcache_interned_strings_buffer: "16"
    php_opcache_max_accelerated_files: "4096"
    php_opcache_max_wasted_percentage: "5"
    php_opcache_validate_timestamps: "1"
    php_opcache_revalidate_path: "0"
    php_opcache_revalidate_freq: "2"
    php_opcache_max_file_size: "0"

OpCache ini directives that are often customized on a system. Make sure you have enough memory and file slots allocated in the OpCache (`php_opcache_memory_consumption`, in MB, and `php_opcache_max_accelerated_files`) to contain all the PHP code you are running. If not, you may get less-than-optimal performance!

For custom opcache.so location provide full path with `php_opcache_zend_extension`.

    php_opcache_conf_filename: [platform-specific]

The platform-specific opcache configuration filename. Generally the default should work, but in some cases, you may need to override the filename.

### APCu-related Variables

    php_enable_apc: true

Whether to enable APCu. Other APCu variables will be ineffective if this is set to false.

    php_apc_shm_size: "96M"
    php_apc_enable_cli: "0"

APCu ini directives that are often customized on a system. Set the `php_apc_shm_size` so it will hold all cache entries in memory with a little overhead (fragmentation or APC running out of memory will slow down PHP *dramatically*).

    php_apc_conf_filename: [platform-specific]

The platform-specific APC configuration filename. Generally the default should work, but in some cases, you may need to override the filename.

#### Ensuring APC is installed

If you use APC, you will need to make sure APC is installed (it is installed by default, but if you customize the `php_packages` list, you need to include APC in the list):

  - *On RHEL/CentOS systems*: Make sure `php-pecl-apcu` is in the list of `php_packages`.
  - *On Debian/Ubuntu systems*: Make sure `php-apcu` is in the list of `php_packages`.

If PPA is used there might be collision between apcu and php versions