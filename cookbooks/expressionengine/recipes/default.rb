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

site_install_dir = "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"

hubot "pulling down repo" do
    body "  *** Cloning down #{node[:repo][:default][:repository]}."
end

repo "default" do
  provider node[:repo][:default][:provider]
  destination site_install_dir
  app_user node[:web_apache][:application_name]
  repository node[:repo][:default][:repository]
  credential node[:repo][:default][:credential]
  revision node[:repo][:default][:revision]
  action node[:repo][:default][:perform_action].to_sym
end

directory "/home/capistrano_repo/shared/css" do
  action :create
  owner node[:web_apache][:application_name]
  group node[:web_apache][:application_name]
end

directory "/home/capistrano_repo/shared/images" do
  action :create
  owner node[:web_apache][:application_name]
  group node[:web_apache][:application_name]
end

link "#{site_install_dir}/assets/css" do
  to "/home/capistrano_repo/shared/css"
  link_type :symbolic
  action :create
end

link "#{site_install_dir}/images" do
  to "/home/capistrano_repo/shared/images"
  link_type :symbolic
  action :create
end

template "#{site_install_dir}/#{node[:ee][:system_folder]}/expressionengine/config/database.php" do
  source "database.php.erb"
  mode 0666
  owner node[:web_apache][:application_name]
  group node[:web_apache][:application_name]
end

file "#{site_install_dir}/#{node[:ee][:system_folder]}/expressionengine/config/config.php" do
  action :touch
  mode 0666
  owner node[:web_apache][:application_name]
  group node[:web_apache][:application_name]
end

execute "rake" do
  cwd "#{site_install_dir}"
  user "root"
  command "/usr/local/bin/rake --verbose --trace sass:build"
  returns [0,1]
  #only run if rake file exists
  only_if { ::File.exists?("#{site_install_dir}/Rakefile") }
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

