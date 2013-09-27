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

# include_recipe "repo::default"

site_install_dir = "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"

deploy_revision site_install_dir do
  symlinks ( "images" => "images", "css" => "assets/css" )
  symlink_before_migrate "" => ""
  revision node[:ee][:update_revision]
  repository node[:repo][:default][:repository]
  migrate false
  shallow_clone true
  enable_submodules true
  user node[:web_apache][:application_name]
  group node[:web_apache][:application_name]
  before_restart do
    release_dir = "#{release_path}"

    execute "install_assets" do
      cwd site_install_dir
      command "bundle install && rake"
      #only run if rake file exists
      only_if { ::File.exists?("#{release_dir}/Rakefile") }
    end

    #Make sure EE permissions are correct
    bash "set_permissions" do
      user "root"
      cwd release_dir
      code <<-EOH
        chmod -R 777 hello/expressionengine/cache
        chmod -R 777 assets/cache
        chmod -R 777 assets/templates
        chmod -R 777 images
        EOH
    end

    template "#{release_dir}/#{node[:ee][:system_folder]}/expressionengine/config/database.php" do
      source "database.php.erb"
      mode 0666
      owner node[:web_apache][:application_name]
      group node[:web_apache][:application_name]
    end

    file "#{release_dir}/#{node[:ee][:system_folder]}/expressionengine/config/config.php" do
      action :touch
      mode 0666
      owner node[:web_apache][:application_name]
      group node[:web_apache][:application_name]
    end
  end
end


rightscale_marker :end




