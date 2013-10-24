#
# Cookbook Name:: newrelic
# Recipe:: install_newrelic_nrsysmond
#
# Copyright 2013, NewSpring Church
#
# All rights reserved - Do Not Redistribute
#

package 'newrelic-sysmod'

service 'newrelic-daemon' do
  supports :start => true, :stop => true, :restart => true, :status => true
  action :nothing
end

template "/etc/newrelic/nrsysmond.cfg" do
  source "nrsysmond.cfg.erb"
  mode 0644
  notifies :restart, "service[newrelic-daemon]"
end

