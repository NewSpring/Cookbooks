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

include_recipe "repo_git::default"

site_install_dir = "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"

repo node[:web_apache][:application_name] do
  destination "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"
  symlinks "images" => "images", "css" => "assets/css"
  action node[:repo][:default][:perform_action].to_sym
  credential node[:repo][:default][:credential]
  revision node[:repo][:default][:revision]
  app_user node[:web_apache][:application_name]
  repository node[:repo][:default][:repository]
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

execute "install_assets" do
  cwd site_install_dir
  command "bundle install && rake"
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

service "apache2" do
  action :reload
end

rightscale_marker :end





