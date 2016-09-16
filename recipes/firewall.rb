#
# Cookbook Name:: container_monitor
# Recipe:: firewall
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

ports = node['container_monitor']['open_ports']

include_recipe 'firewall::default'

firewall_rule "Open ports #{ports}" do
	port ports
end
