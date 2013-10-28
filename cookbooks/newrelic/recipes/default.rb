#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2013, NewSpring Church
#
# All rights reserved - Do Not Redistribute
#
include_recipe "newrelic::do_setup_repository"
include_recipe "newrelic::install_newrelic_nrsysmond"
