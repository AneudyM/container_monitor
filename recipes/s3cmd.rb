#
# Cookbook Name:: container_monitor
# Recipe:: s3cmd
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home_dir = node['container_monitor']['home_dir']

template "#{home_dir}/etc/.s3cfg" do
	source 'etc/s3cmd/s3cfg.erb'
	owner 'root'
	group 'root'
	mode '0600'
end

package 's3cmd' do
	action :install
end
	
