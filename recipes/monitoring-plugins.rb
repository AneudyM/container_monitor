#
# Cookbook Name:: container_monitor
# Recipe:: monitoring-plugins
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

execute 'remove_nagios-plugins' do
	command "apt-get remove -y --purge nagios-plugins*"
	action :run
end

package ['nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-common'] do
        action :install
end

package ['nagios-plugins-extra', 'nagios-plugins-standard'] do
	action :install
end

#################################
## Configure Monitoring Plugins
#################################
config_dir='/etc/icinga2/conf.d'

template "#{config_dir}/commands.conf" do
	source 'etc/icinga2/conf.d/commands.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template "#{config_dir}/services.conf" do
	source 'etc/icinga2/conf.d/services.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template "#{config_dir}/hosts.conf" do
	source 'etc/icinga2/conf.d/hosts.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template "#{config_dir}/templates.conf" do
	source 'etc/icinga2/conf.d/templates.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/icinga2/features-enabled/ido-mysql.conf' do
	source 'icinga2/features-enabled/ido-mysql.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

## Restart the Icinga2 Service
service 'icinga2' do
	action :restart
end
