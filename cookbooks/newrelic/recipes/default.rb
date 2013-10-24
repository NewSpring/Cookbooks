#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

service "apache2" do
  supports :restart => true
  action [ :enable ]
end

include_recipe "newrelic::install_newrelic_agent"
