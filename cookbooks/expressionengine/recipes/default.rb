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

repo "#{node[:web_apache][:application_name]}" do
  provider node[:repo][:default][:provider]
  destination site_install_dir
  app_user node[:web_apache][:application_name]
  repository node[:repo][:default][:repository]
  credential node[:repo][:default][:credential]
  create_dirs_before_symlink %w{images css}
  symlinks "images" => "images", "css" => "assets/css"
  revision node[:repo][:default][:revision]
  action node[:repo][:default][:perform_action].to_sym
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

execute "install_assets" do
  cwd site_install_dir
  command "bundle install && rake"
  #only run if rake file exists
  only_if { ::File.exists?("#{site_install_dir}/Rakefile") }
end

# ruby_block "install_assets" do
#   block do
#     #does rakefile exist?
#     if FileTest.exist?("#{node[:repo][:default][:destination]}/#{node[:ee][:main]}/Rakefile")
#     cmd = Mixlab::ShellOut.new("bundle install && rake", :cwd => "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}").run_command
#       unless cmd.exitstatus == 0 or cmd.exitstatus == 2
#         Chef::Application.fatal!(cmd.stderr)
#       end
#     end
#   end
# end

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

