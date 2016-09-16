#
# Cookbook Name:: container_monitor
# Recipe:: httpd
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

httpdDocRoot = node['container_monitor']['httpd']['httpdDocRoot']

package 'apache2' do
	action :install
end

package ['php5', 'php5-ldap', 'php5-intl', 'libapache2-mod-php5', 'php5-mysql'] do
	action :install
end

file "#{httpdDocRoot}/index.php" do
	content '<?php phpinfo(); ?>'
	action :create
end


