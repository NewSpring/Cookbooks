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
  symlinks "images" => "images"
  action node[:repo][:default][:perform_action].to_sym
  credential node[:repo][:default][:credential]
  revision node[:ee][:update_revision]
  app_user node[:web_apache][:application_name]
  repository node[:repo][:default][:repository]
  shallow_clone true
end

ruby_block "Set the Database Config" do
  block do
    file = Chef::Util::FileEdit.new("#{site_install_dir}/config/config.#{node[:ee][:env]}.php")
    file.search_file_replace_line(/\['hostname'\]/, "$env_db['hostname'] = '#{node[:ee][:hostname]}';" )
    file.search_file_replace_line(/\['username'\]/, "$env_db['username'] = '#{node[:ee][:username]}';" )
    file.search_file_replace_line(/\['password'\]/, "$env_db['password'] = '#{node[:ee][:password]}';" )
    file.search_file_replace_line(/\['database'\]/, "$env_db['database'] = '#{node[:ee][:database]}';" )
    file.write_file
  end
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

rvm_shell "run_bundler_install" do
  ruby_string node[:rvm][:default_ruby]
  cwd "#{site_install_dir}"
  user "root"
  code %{bundle install --without development}
  environment("RAKE_ENV" => "production")
  returns [0,1]
  #only run if rake file exists
  only_if { ::File.exists?("#{site_install_dir}/Gemfile") }
end

rvm_shell "run_rake_compile_assets" do
  ruby_string node[:rvm][:default_ruby]
  cwd "#{site_install_dir}"
  user "root"
  code %{rake --verbose --trace #{node[:ee][:rake]}}
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
  message "Updated #{node[:ee][:update_revision]} on #{node[:cloud][:hostname]}."
  action :speak
end
