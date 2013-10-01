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

include_recipe "repo::default"

hubot "pulling down repo" do
    body "  ***  Pulling down updated #{node[:repo][:default][:repository]}."
end

site_install_dir = "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"

repo "default" do
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

execute "rake" do
  cwd "#{site_install_dir}"
  user "root"
  command "/usr/local/bin/rake --verbose --trace sass:build"
  environment {"RAKE_ENV" => "production"}
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

service "apache2" do
  action :reload
end

rightscale_marker :end





