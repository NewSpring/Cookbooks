site_install_dir = "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}"

deploy "/home/capistrano_repo" do
  repo "git@github.com/NewSpring/NewSpring"
  user node[:web_apache][:application_name]
  enable_submodules true
  environment "RAKE_ENV" => "production"
  action :rollback
  symlinks "images" => "images"
end

link "#{site_install_dir}" do
  to "/home/capistrano_repo/current"
  link_type :symbolic
  action :create
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

include_recipe "hipchat::default"

hipchat_msg "default" do
  token node[:hipchat][:token]
  room node[:hipchat][:room]
  nickname "RightScale"
  message "Rolled back to previous revision on #{node[:cloud][:hostname]}."
  action :speak
end

