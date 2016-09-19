#
# Cookbook Name:: container_monitor
# Recipe:: default
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

include_recipe 'container_monitor::repositories'
include_recipe 'container_monitor::ug_admin'
include_recipe 'container_monitor::firewall'
include_recipe 'container_monitor::structure'

include_recipe 'container_monitor::httpd'
include_recipe 'container_monitor::mysqld'

include_recipe 'container_monitor::icinga2-ido'
include_recipe 'container_monitor::icinga2'
include_recipe 'container_monitor::monitoring-plugins'

include_recipe 'container_monitor::icingaweb2'

include_recipe 'container_monitor::docker'
include_recipe 'container_monitor::httpd-container'
include_recipe 'container_monitor::mysqld-container'

include_recipe 'container_monitor::s3cmd'

include_recipe 'container_monitor::backups'
include_recipe 'container_monitor::logs'

