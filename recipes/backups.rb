#
# Cookbook Name:: container_monitor
# Recipe:: backups
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

home_dir = node['container_monitor']['home_dir']
backupsbucket = node['container_monitor']['backupsbucket']

# The "home_dir" variable represents the container monitoring solutions
# home directory.
directory "#{home_dir}/scripts" do
	action :create
	not_if do ::Dir.exists?("#{home_dir}/scripts") end
end

cookbook_file "#{home_dir}/scripts/container_backups.sh" do
	source 'container_backups.sh'
	owner 'root'
	group 'root'
	mode '0700'
	action :create
end

# Add cron entries for the periodical collection and transference of 
# backups.
cron 'create_container_backups' do
	minute '59'
	hour '18'
	day '*'
	weekday '*'
	command "#{home_dir}/container_backups.sh"
	action :create
end

cron 'send_backups_to_S3' do
	minute '00'
	hour '19'
	day '*'
	weekday '*'
	command "s3cmd --config=#{home_dir}/etc/.s3cfg sync #{home_dir}/backups/ s3://#{backupsbucket}"
	action :create
end
