#
# Cookbook Name:: container_monitor
# Recipe:: icinga2-ido
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'icinga2-ido-mysql' do
	action :install
end

execute 'enable_icinga2-ido-mysql_module' do
	command 'icinga2 feature enable ido-mysql'
	action :run
end

