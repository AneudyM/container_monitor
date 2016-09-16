#
# Cookbook Name:: container_monitor
# Recipe:: control
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home_dir = node['container_monitor']['home_dir']
httpdContainerDocRoot = node['container_monitor']['httpd-container']['local_document_root']
mysqldContainerDataDir = node['container_monitor']['mysqld-container']['local_data_dir']
ports = node['container_monitor']['open_ports']
icinga2_home = node['container_monitor']['icinga2']['home_dir']
icingaweb2_home = node['container_monitor']['icingaweb2']['home_dir']
ido_home = node['container_monitor']['icinga2-ido']['home_dir']
db_scripts = node['container_monitor']['db_scripts']
host = node['container_monitor']['host']
test_password = node['container_monitor']['test_password']
check_files = node['container_monitor']['check_files']
httpdDocRoot = node['container_monitor']['httpd']['httpdDocRoot']
logsbucket = node['container_monitor']['logsbucket']
backupsbucket = node['container_monitor']['backupsbucket']
