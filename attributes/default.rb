default['container_monitor']['home_dir'] = '/opt/container_monitor'
default['container_monitor']['httpd-container']['local_document_root'] = '/opt/container_monitor/containers/www/'
default['container_monitor']['mysqld-container']['local_data_dir'] = '/opt/container_monitor/containers/db'
default['container_monitor']['check_files'] = '/opt/container_monitor/check'
default['container_monitor']['httpd']['httpdDocRoot'] = '/var/www/html'
default['container_monitor']['open_ports'] = 80
default['container_monitor']['allow_ssh'] = true
default['container_monitor']['db_scripts'] = '/opt/container_monitor/db_scripts'
default['container_monitor']['icingaweb2']['home_dir'] = '/usr/share/icingaweb2'
default['container_monitor']['icinga2-ido']['home_dir'] = '/usr/share/icinga2-ido-mysql'
default['container_monitor']['icinga2']['home_dir'] = '/usr/share/icinga2'
default['container_monitor']['host'] = '127.0.0.1'
default['container_monitor']['logsbucket'] = 'logsbucket'
default['container_monitor']['backupsbucket'] = 'backupsbucket'
# Never embbed passwords in your code. This is done only for testing purposes.
# I recommend using the random password method.
default['container_monitor']['test_password'] = 'admin1234' 

