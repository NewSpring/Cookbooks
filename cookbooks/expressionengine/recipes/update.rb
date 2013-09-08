# expressionengine::update
#
# Recipe:: update
#
# Copyright 2013, NewSpring Church, Inc.
#
# All rights reserved - Do Not Redistribute
#
#
## Then, deploy
rightscale_marker :begin

repo node[:web_apache][:application_name] do
  destination "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"
  action node[:repo][:default][:perform_action].to_sym
end

template "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}/#{node[:ee][:system_folder]}/expressionengine/config/database.php" do
  source "database.php.erb"
  mode 0666
  owner node[:web_apache][:application_name]
  group node[:web_apache][:application_name]
end

file "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}/#{node[:ee][:system_folder]}/expressionengine/config/config.php" do
  action :touch
  mode 0666
  owner node[:web_apache][:application_name]
  group node[:web_apache][:application_name]
end

service "apache2" do
  action :reload
end

rightscale_marker :end





