#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2013, NewSpring Church
#
# All rights reserved - Do Not Redistribute
#

service "apache2" do
  supports :restart => true
  action [ :enable ]
end

include_recipe "newrelic::do_setup_repository"
include_recipe "newrelic::install_newrelic_php5"
include_recipe "newrelic::install_newrelic_nrsysmond"
