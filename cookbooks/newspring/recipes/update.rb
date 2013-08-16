#
# Cookbook Name:: newspring
# Recipe:: default
#
# Copyright 2012, NewSpring Church, Inc.
#
# All rights reserved - Do Not Redistribute
#
#
## Then, deploy
rightscale_marker :begin

deploy_revision "/var/www/newspring.cc" do
  revision "master"
  repository "git@github.com:NewSpring/NewSpring.git"
  user "newspring"
  group "newspring"
  action :deploy
  ssh_wrapper "/var/www/newspring.cc/deploy-ssh-wrapper"
  migrate false
  enable_submodules true
  shallow_clone true
  symlinks "images" => "images", "events" => "events"
  symlink_before_migrate "" => ""
  before_symlink do
      directory "#{release_path}/assets/cache" do
        user "newspring"
        group "newspring"
        mode 00777
        recursive true
      end

      directory "#{release_path}/hello/expressionengine/cache" do
        user "newspring"
        group "newspring"
        mode 00777
        recursive true
      end

      directory "#{release_path}/assets/templates" do
        user "newspring"
        group "newspring"
        mode 00777
        recursive true
      end

      template "#{release_path}/hello/expressionengine/config/database.php" do
        source "database.php.erb"
        user "newspring"
        group "newspring"
        mode 00666
      end

      file "#{release_path}/hello/expressionengine/config/config.php" do
        user "newspring"
        group "newspring"
        mode 0666
        action :touch
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





