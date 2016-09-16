#
# Cookbook Name:: container_monitor
# Recipe:: icingaweb2
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

home_dir = node['container_monitor']['home_dir']
db_scripts = node['container_monitor']['db_scripts']
host = node['container_monitor']['host']
icingaweb2_home = node['container_monitor']['icingaweb2']['home_dir']
test_password = node['container_monitor']['test_password']
check_files = node['container_monitor']['check_files']


#############################
## INSTALL ICINGAWEB2 MODULE
#############################

cookbook_file "#{home_dir}/scripts/icingaweb2_installer.sh" do
	source 'icingaweb2_installer.sh'
	mode '0755'
end

execute "Install Icingaweb2" do
	command "sh #{home_dir}/scripts/icingaweb2_installer.sh"
	action :run
end

execute "Directory Setup" do
	command "icingacli setup config directory"
	action :run
end

###############################
## CREATE ICINGAWEB2 DATABASE
###############################

cookbook_file "#{db_scripts}/create_icingaweb2_db.sql" do
	source 'create_icingaweb2_db.sql'
	owner 'root'
	group 'root'
	mode '0644'
end

execute 'create_icingaweb2_db' do
	command "\
		mysql	-h #{host} \
			-uroot \
			-p#{test_password} < #{db_scripts}/create_icingaweb2_db.sql \
		&& touch #{check_files}/created_icingaweb2_db"
	not_if do ::File.exists?("#{check_files}/created_icingaweb2_db") end
end

execute 'load_icingaweb2_schema' do
	command "\
		mysql	-h #{host} \
			-uroot \
			-p#{test_password} \
			-D icingaweb2 < #{icingaweb2_home}/etc/schema/mysql.schema.sql \
		&& touch #{check_files}/loaded_icingaweb2_schema"
	not_if do ::File.exists?("#{check_files}/loaded_icingaweb2_schema") end
end

######################################
## CREATE ICINGAWEB2 USER IN DATABASE
######################################
cookbook_file "#{home_dir}/scripts/create_icingaweb2_db_user.sh" do
	source 'create_icingaweb2_db_user.sh'
	user 'root'
	group 'root'
	mode '0640'
end

execute 'create_icingaweb2_db_user' do
	command "sh #{home_dir}/scripts/create_icingaweb2_db_user.sh"
	action :run
end

execute 'create_icingaweb2_db_user' do
	command "\
		mysql	-h #{host} \
			-uroot \
			-p#{test_password} < #{db_scripts}/create_icingaweb2_db_user.sql \
		&& touch #{check_files}/created_icingaweb2_db_user"
	not_if do ::File.exists?("#{check_files}/created_icingaweb2_db_user") end
end

######################################
## LOAD CONFIGURATION FILES
######################################
directory '/etc/icingaweb2/modules/monitoring'
directory '/etc/icingaweb2/enabledModules'

execute 'enable_icinga2_monitoring' do
	cwd '/etc/icingaweb2/enabledModules'
	command "ln -s #{icingaweb2_home}/modules/monitoring/ monitoring"
	not_if do ::File.exists?('/etc/icingaweb2/enabledModules/monitoring') end
end

template '/etc/php5/apache2/php.ini' do
	source 'php.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/icingaweb2/resources.ini' do
	source 'icingaweb2/resources.ini.erb'
	owner 'root'
	group 'icingaweb2'
	mode '0660'
end

template '/etc/icingaweb2/config.ini' do
	source '/icingaweb2/config.ini.erb'
	owner 'root'
	group 'icingaweb2'
	mode '0660'
end

template '/etc/icingaweb2/authentication.ini' do
        source 'icingaweb2/authentication.ini.erb'
        owner 'root'
        group 'icingaweb2'
        mode '0660'
end

template '/etc/icingaweb2/groups.ini' do
        source 'icingaweb2/groups.ini.erb'
        owner 'root'
        group 'icingaweb2'
        mode '0660'
end

template '/etc/icingaweb2/roles.ini' do
        source 'icingaweb2/roles.ini.erb'
        owner 'root'
        group 'icingaweb2'
        mode '0660'
end

template '/etc/icingaweb2/modules/monitoring/config.ini' do
        source 'icingaweb2/modules/monitoring/config.ini.erb'
        owner 'root'
        group 'icingaweb2'
        mode '0660'
end

template '/etc/icingaweb2/modules/monitoring/backends.ini' do
        source 'icingaweb2/modules/monitoring/backends.ini.erb'
        owner 'root'
        group 'icingaweb2'
        mode '0660'
end

template '/etc/icingaweb2/modules/monitoring/commandtransports.ini' do
        source 'icingaweb2/modules/monitoring/commandtransports.ini.erb'
        owner 'root'
        group 'icingaweb2'
        mode '0660'
end







