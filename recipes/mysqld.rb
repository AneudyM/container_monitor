#
# Cookbook Name:: container_monitor
# Recipe:: mysqld
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

test_password = node['container_monitor']['test_password']

ENV['DEBIAN_FRONTEND'] = 'noninteractive'

script 'Install MySQL' do
	interpreter 'sh'
	code <<-EOH
		echo "mysql-server mysql-server/root_password password #{test_password}" | sudo debconf-set-selections
		echo "mysql-server mysql-server/root_password_again password #{test_password}" | sudo debconf-set-selections
		apt-get -y install mysql-client mysql-server
	EOH
end
