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
include_recipe "repo::default"

site_install_dir = "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"

repo "default" do
  destination "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"
  symlinks "images" => "images", "css" => "assets/css"
  action node[:repo][:default][:perform_action].to_sym
  credential node[:repo][:default][:credential]
  revision node[:ee][:update_revision]
  app_user node[:web_apache][:application_name]
  repository node[:repo][:default][:repository]
end

if node[:ee][:env] == ''
  node.set[:ee][:env] = "prod"
end

template "#{site_install_dir}/config/config.#{node[:ee][:env]}.php" do
  source "config.php.erb"
  mode 0666
  owner node[:web_apache][:application_name]
  group node[:web_apache][:application_name]
end

file "#{site_install_dir}/#{node[:ee][:system_folder]}/expressionengine/config/database.php" do
  action :touch
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
  environment("RAKE_ENV" => "production")
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

ruby_block "Get Hostname" do
  block do
    if File.exists?("/etc/hostname")
      node.set[:cloud][:hostname] = File.open("/etc/hostname").read.strip
    else
      log "   HOSTNAME FILE DOESN'T EXIST!"
    end
  end
end

include_recipe "hipchat::default"

hipchat_msg "default" do
  token node[:hipchat][:token]
  room node[:hipchat][:room]
  nickname "RightScale"
  message "Updated Application on #{node[:cloud][:hostname]}."
  action :speak
end




