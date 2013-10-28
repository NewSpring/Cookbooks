#
# Cookbook Name:: newrelic
# Recipe:: install_newrelic_php5
#
# Copyright 2013, NewSpring Church
#
# All rights reserved - Do Not Redistribute
#

service "apache2" do
  supports :restart => true
  action [ :enable ]
end

package 'newrelic-php5'

template "/etc/php5/conf.d/newrelic.ini" do
  source "newrelic.ini.erb"
  mode 0644
  notifies :restart, "service[apache2]"
end

