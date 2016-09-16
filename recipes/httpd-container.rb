#
# Cookbook Name:: container_monitor
# Recipe:: httpd-container
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

httpdContainerDocRoot = node['container_monitor']['httpd-container']['local_document_root']

# Local directory to link to the container's document root
directory "#{httpdContainerDocRoot}" do
	action :create
end

file "#{httpdContainerDocRoot}/index.php" do
	content '<?php echo "You are visiting the Docker HTTPd/Apache Container"; ?>' 
	mode '0755'
end

docker_image 'php' do
	tag '5.6-apache'
	action :pull
end

docker_container 'httpd-container' do
	repo 'php'
	tag '5.6-apache'
	port '49111:80'
	volumes [ "#{httpdContainerDocRoot}:/var/www/html" ]
	action :run
end

