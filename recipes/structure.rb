#
# Cookbook Name:: container_monitor
# Recipe:: structure
#
# Copyright (c) 2016 Aneudy Mota , All Rights Reserved.

home_dir = node['container_monitor']['home_dir']
httpdContainerDocRoot = node['container_monitor']['httpd-container']['local_document_root']
mysqldContainerDataDir = node['container_monitor']['mysqld-container']['local_data_dir']
check_files = node['container_monitor']['check_files']
db_scripts = node['container_monitor']['db_scripts']

directory "#{home_dir}" do
	action :create
	not_if do ::Dir.exists?("#{home_dir}") end
end

directory "#{home_dir}/containers" do
        action :create
        not_if do ::Dir.exists?("#{home_dir}/containers") end
end

directory "#{mysqldContainerDataDir}" do
        action :create
        not_if do ::Dir.exists?("#{mysqldContainerDataDir}") end
end

directory "#{check_files}" do
        action :create
        not_if do ::Dir.exists?("#{check_files}") end
end

directory "#{httpdContainerDocRoot}" do
        action :create
        not_if do ::Dir.exists?("#{httpdContainerDocRoot}") end
end

directory "#{check_files}" do
        action :create
        not_if do ::Dir.exists?("#{check_files}") end
end

directory "#{db_scripts}" do
        action :create
        not_if do ::Dir.exists?("#{db_scripts}") end
end

directory "#{home_dir}/scripts" do
        action :create
        not_if do ::Dir.exists?("#{home_dir}/scripts") end
end

directory "#{home_dir}/backups" do
        action :create
        not_if do ::Dir.exists?("#{home_dir}/backups") end
end

directory "#{home_dir}/logs" do
        action :create
        not_if do ::Dir.exists?("#{home_dir}/logs") end
end

directory "#{home_dir}/etc" do
        action :create
        not_if do ::Dir.exists?("#{home_dir}/etc") end
end

directory "#{home_dir}/archived" do
	action :create
	not_if do ::Dir.exists?("#{home_dir}/archived") end
end


