#
# Cookbook Name:: newrelic
# Recipe:: install_newrelic_php5
#
# Copyright 2013, NewSpring Church
#
# All rights reserved - Do Not Redistribute
#
package "python-pip"

python_pip "newrelic_plugin_agent" do
  action :install
end

ruby_block "Get Hostname" do
  block do
    if File.exists?("/etc/hostname")
      node.set[:cloud][:hostname] = File.open("/etc/hostname")
    end
  end
end

template "/etc/newrelic/newrelic_plugin_agent.cfg" do
  source "newrelic_plugin_agent.cfg.erb"
  mode 664
  user "root"
  group "root"
  variables({
    :hostname => "#{node[:cloud][:hostname]}"
  })
end

template "/etc/init.d/newrelic-plugin-agent" do
  mode 00755
  source "newrelic-plugin-agent-init.erb"
  variables({
    :config => "/etc/newrelic/newrelic_plugin_agent.cfg",
    :user => "root",
    :group => "root"
  })
end

execute "apc-ng.php" do
  command "cp /opt/newrelic_plugin_agent/apc-nrp.php /var/www/#{node[:newrelic][:fqdn]}/"
end

service "newrelic-plugin-agent" do
  supports :restart => true, :stop => true, :start => true
  action [ :enable, :start]
end

