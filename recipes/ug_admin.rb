#
# Cookbook Name:: container_monitor
# Recipe:: ug_admin
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#################
## CREATE GROUPS
#################
group 'www-data'
group 'mysql'
group 'nagios'
group 'docker'
group 'icingaweb2'

################
## CREATE USERS
################
user 'www-data' do
	comment 'HTTPD User'
	system true
	home '/var/www'
	group 'www-data'
	shell '/usr/sbin/nologin'
end

user 'mysql' do
	system true
	comment 'MySQL Server'
	home '/nonexistent'
	group 'mysql'
	shell '/bin/false'
end

user 'nagios' do
	system true
	comment 'Icinga2 Service'
	home '/var/lib/nagios'
	group 'nagios'
	shell '/bin/false'
end

#################
## MODIFY GROUPS
#################
group 'nagios' do
	action :modify
	members 'www-data'
	append true
end

group 'icingaweb2' do
	action :modify
	members 'www-data'
	append true
end

	
