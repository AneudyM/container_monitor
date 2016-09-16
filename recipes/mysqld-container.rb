#
# Cookbook Name:: container_monitor
# Recipe:: mysqld-container
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

home_dir = node['container_monitor']['home_dir']
test_password = node['container_monitor']['test_password']

docker_image 'mysql' do
	tag '5.6'
	action :pull_if_missing
end

docker_container 'mysqld-container' do
	repo 'mysql'
	tag '5.6'
	volumes "#{home_dir}/containers/db:/var/lib/mysql"
	env "MYSQL_ROOT_PASSWORD=#{test_password}"
	port '49222:3306'
	action [ :create, :run ]
end
	
