#
# Cookbook Name:: hipchat
# Recipe:: default
#
# Copyright (C) 2013 Drew Delianides
#
# All rights reserved - Do Not Redistribute
#
chef_gem 'httparty' do
  version '0.11.0'
  action :nothing
end.run_action(:install)

chef_gem 'hipchat' do
 action :nothing
end.run_action(:install)

