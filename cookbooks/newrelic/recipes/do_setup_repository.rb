#
# Cookbook Name:: newrelic
# Recipe:: do_setup_repository
#
# Copyright 2013, NewSpring Church
#
# All rights reserved - Do Not Redistribute
#

apt_repository 'newrelic' do
  uri          node['newrelic']['apt']['repo']['url']
  distribution node['newrelic']['apt']['repo']['distribution']
  components   node['newrelic']['apt']['repo']['components']
  key          node['newrelic']['apt']['repo']['key']
  only_if    { node['platform_family'] == 'debian' }
end
