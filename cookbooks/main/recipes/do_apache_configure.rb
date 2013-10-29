rightscale_marker

http_port = "80"

# Disable default vhost.
# See https://github.com/rightscale/cookbooks/blob/master/apache2/definitions/apache_site.rb for the "apache_site" definition.
apache_site "000-default" do
  enable false
end

# Updating apache listen ports configuration
template "#{node[:apache][:dir]}/ports.conf" do
  cookbook "apache2"
  source "ports.conf.erb"
  variables :apache_listen_ports => http_port
end

template "/etc/apache2/sites-available/localhost.conf" do
  source "localhost.conf.erb"
  mode 0644
end

apache_site "localhost.conf" do
  enable true
end
