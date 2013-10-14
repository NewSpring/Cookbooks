include_recipe "php::module_apc"

template "/etc/php5/apache2/conf.d/apc.ini" do
  source "apc.ini.erb"
  mode "644"
  owner "root"
  group "root"
end
