#
# Cookbook Name:: expressionengine
# Recipe:: mulitsite
#
# Copyright 2013, NewSpring Church
#
# All rights reserved - Do Not Redistribute
#
include_recipe "expressionengine"

multisite "perrynoble" do
  path "/var/www/perrynoble.com"
  system_path "/var/www/newspring.cc/current/"
  site "perrynoble.com"
  symlinks ["themes"]
end

