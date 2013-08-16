#
# Cookbook Name:: main
# Recipe:: default
#
# Copyright 2012, NewSpring Church
#
# All rights reserved - Do Not Redistribute
#

#Sets up the message of the day or login screen on Ubuntu 10.04
template "/etc/motd" do 
  source "motd.erb"
  mode "0777"
  owner "root"
  group "root"
end
