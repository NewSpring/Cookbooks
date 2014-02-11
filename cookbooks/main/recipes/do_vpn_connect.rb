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
  action :create_if_missing
end

execute "apt-get update" do
  command "apt-get update"
end

package "openconnect" do
  action :install
end

ruby_block "Adding Private IP of AD Server to /etc/hosts" do
  block do
    file = Chef::Util::FileEdit.new("/etc/hosts")
    file.insert_line_if_no_match(
      "cen-dc001.ad.newspring.cc",
      "10.0.60.10 cen-dc001.ad.newspring.cc"
    )
    file.write_file
  end
end

package "monit" do
  action :install
end

template "/etc/monit/monitrc" do
  source "monit.erb"
  mode 0700
  owner "root"
  group "root"
  action :create_if_missing
end

template "/etc/monit/conf.d/newspring_vpn" do
  source "newspring_vpn.monit.erb"
  mode 0777
  owner "root"
  group "root"
  action :create_if_missing
end

execute "monit start" do
  command "monit start all"
  only_if do File.exists?("/var/run/monit.pid") end
  action :nothing
end

execute "monit load daemon" do
  command "/etc/init.d/monit start"
  notifies :run, "execute[monit start]"
end
