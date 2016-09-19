#
# Cookbook Name:: container_monitor
# Recipe:: logs
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

home_dir = node['container_monitor']['home_dir']
logsbucket = node['container_monitor']['logsbucket']

execute 'create_initial_timestamp_file' do
	command "echo \"$(date +'%Y-%m-%dT%H:%M:%S')\" > #{home_dir}/etc/timestamp.conf"
	action :run
end

cookbook_file "#{home_dir}/scripts/container_logs.sh" do
	source 'container_logs.sh'
	owner 'root'
	group 'root'
	mode '0700'
end

cron 'create_container_logs' do
	minute '55'
	hour '18'
	day '*'
	weekday '*'
	command "#{home_dir}/scripts/container_logs.sh"
	action :create
end

cron 'send_logs_to_S3' do
	minute '00'
	hour '19'
	day '*'
	weekday '*'
	command "s3cmd --config=#{home_dir}/etc/.s3cfg sync #{home_dir}/archived/ s3://#{logsbucket}"
	action :create
end

