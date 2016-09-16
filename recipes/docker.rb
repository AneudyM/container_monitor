#
# Cookbook Name:: container_monitor
# Recipe:: docker
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

docker_service 'default' do
	action [ :create, :start ]
end

