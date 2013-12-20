#
# Cookbook Name:: main
# Recipe:: do_vpn_connect
#
# Copyright 2013, NewSpring Church
#
# All rights reserved - Do Not Redistribute

template "/etc/init.d/newspring_vpn" do
  source "newspring_vpn.init.erb"
  mode 0777
  owner "root"
  group "root"
end

execute "apt-get update" do
  command "apt-get update"
end

package "monit" do
  action :install
end

template "/etc/monit/monitrc" do
  source "monit.erb"
  mode 0777
  owner "root"
  group "root"
end

template "/etc/monit/conf.d/newspring_vpn" do
  source "newspring_vpn.monit.erb"
  mode 0777
  owner "root"
  group "root"
end

execute "monit start" do
  command "monit start all"
end
