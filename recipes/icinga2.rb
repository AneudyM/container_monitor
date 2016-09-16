#
# Cookbook Name:: container_monitor
# Recipe:: icinga2
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

db_scripts = node['container_monitor']['db_scripts']
host = node['container_monitor']['host']
check_files = node['container_monitor']['check_files']
test_password = node['container_monitor']['test_password']
ido_home = node['container_monitor']['icinga2-ido']['home_dir']


# Install the Icinga2 Service
package 'icinga2' do
	action :install
end

service 'icinga2' do
	action :start
end

# Add the icinga DB Creation SQL Script to the Node
cookbook_file "#{db_scripts}/create_icinga_db.sql" do
	source 'icinga-schema.sql'
	owner 'root'
	group 'root'
	mode '0644'
end

# Seed the icinga DB Creation SQL Script to MySQL
execute 'create_icinga_db' do
	command "\
		mysql	-h #{host} \
			-uroot \
			-p#{test_password} < #{db_scripts}/create_icinga_db.sql \
		&& touch #{check_files}/created_icinga_db"
	not_if do ::File.exists?("#{check_files}/created_icinga_db") end
end

# Load the table schema to the icinga DB in MySQL
execute 'load_icinga_schema' do
	command "\
		mysql	-h #{host} \
			-uroot \
			-p#{test_password} \
			-D icinga < #{ido_home}/schema/mysql.sql \
		&& touch #{check_files}/loaded_icinga_schema"
	not_if do ::File.exists?("#{check_files}/loaded_icinga_schema") end
end



