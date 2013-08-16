
# Cookbook Name:: newspring
# Recipe:: default
#
# Copyright 2012, NewSpring Church, Inc.
#
# All rights reserved - Do Not Redistribute

rightscale_marker :begin

group "newspring" do
  gid 5001
end

user "newspring" do 
  uid 2001
  gid "newspring"
  shell "/dev/null"
end

application "newspring" do
  path "/var/www/newspring.cc"
  owner "newspring"
  group "newspring"
  repository "git@github.com:NewSpring/NewSpring.git"
  deploy_key node[:newspring][:deploy_key]
  symlinks "images" => "images", "events/current" => "events"
  create_dirs_before_symlink ["../shared/images"]  
  revision node[:newspring][:branch]
  mod_php_apache2
  migrate false
  before_symlink do
      template "#{release_path}/hello/expressionengine/config/database.php" do
        source "database.php.erb"
        user "newspring"
        group "newspring"
        mode 0666
      end

      file "#{release_path}/hello/expressionengine/config/config.php" do
        user "newspring"
        group "newspring"
        mode "0666"
        action :touch
      end
  end
  before_deploy do
    application "events" do
      user "newspring"
      group "newspring"
      path "#{shared_path}"
      repository "git@github.com:NewSpring/NewSpring-Events.git"
      revision "master"
      deploy_key node[:newspring][:deploy_key]      
    end
  end
end

bash "set_permissions" do
  user "root"
  cwd "/var/www/newspring.cc/current"
  code <<-EOH
    chmod -R 777 hello/expressionengine/cache
    chmod -R 777 assets/cache
    chmod -R 777 assets/templates
    chmod -R 777 images
  EOH
end

rightscale_marker :end

