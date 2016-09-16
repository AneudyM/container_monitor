#
# Cookbook Name:: container_monitor
# Recipe:: repositories
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

apt_repository		'icinga2' do
	uri		'ppa:formorer/icinga'
	distribution 	node['lsb']['codename']
end

apt_repository		'icingaweb2' do
	uri		'http://packages.icinga.org/ubuntu'
	key		'http://packages.icinga.org/icinga.key'
	distribution	"icinga-#{node['lsb']['codename']}"
	components	['main']
end
