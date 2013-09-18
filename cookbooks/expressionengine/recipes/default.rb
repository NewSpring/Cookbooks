# expressionengine::default
#
# Recipe:: default
#
# Copyright 2013, NewSpring Church, Inc.
#
# All rights reserved - Do Not Redistribute

rightscale_marker :begin

group node[:web_apache][:application_name] do
  gid 5001
end

user node[:web_apache][:application_name] do
  uid 2001
  gid node[:web_apache][:application_name]
  shell "/dev/null"
end

repo "#{node[:web_apache][:application_name]}" do
  provider node[:repo][:default][:provider]
  destination "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"
  app_user node[:web_apache][:application_name]
  repository node[:repo][:default][:repository]
  credential node[:repo][:default][:credential]
  symlinks "images" => "images", "css" => "assets/css" #, "events/current" => "events"
  create_dirs_before_symlink ["images","css"]
  revision node[:repo][:default][:revision]
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

ruby_block "install_assets" do
  block do
    r = Chef::Resource::Execute.new("install_assets")
    r.cwd node[:repo][:default][:destination]
    r.command "bundle install && rake"
    r.returns [0,2]
    r.run_action(:create)
  end
end

#Make sure EE permissions are correct
bash "set_permissions" do
 user "root"
 cwd "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"
 code <<-EOH
   chmod -R 777 hello/expressionengine/cache
   chmod -R 777 assets/cache
   chmod -R 777 assets/templates
   chmod -R 777 images
 EOH
end

#Create Vhost
web_app "#{node[:ee][:main]}" do
  cookbook "apache2"
  template "web_app.conf.erb"
  docroot "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"
  vhost_port http_port
  server_name node[:ee][:main]
  server_aliases ["www.#{node[:ee][:main]}"]
  allow_override node[:web_apache][:allow_override]
  apache_log_dir node[:apache][:log_dir]
end

rightscale_marker :end

