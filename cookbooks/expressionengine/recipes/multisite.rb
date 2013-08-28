require 'domainatrix'

http_port = "80"

node[:ee][:multisite].each do |m|

  domain = Domainatrix.parse(m)

  if domain.subdomain == ""
    site_name = domain.domain
    cookie_domain = "#{domain.domain}.#{domain.public_suffix}"
  else
    site_name = domain.subdomain
    cookie_domain = "#{domain.subdomain}.#{domain.domain}.#{domain.public_suffix}"
  end

  template "#{node[:repo][:default][:destination]}/#{cookie_domain}/index.php" do
    source "index.php.erb"
    mode 0666
    owner "newspring"
    group "newspring"
    variables({
      :site_name => "#{site_name}",
      :site_url => "#{domain.url}",
      :cookie_domain => "#{cookie_domain}"
    })
  end

  template "#{node[:repo][:default][:destination]}/#{cookie_domain}/admin.php" do
    source "admin.php.erb"
    mode 0666
    owner "newspring"
    group "newspring"
    variables({
      :site_name => "#{site_name}",
      :site_url => "#{domain.url}",
      :cookie_domain => "#{cookie_domain}"
    })
  end

  template "#{node[:repo][:default][:destination]}/#{cookie_domain}/.htaccess" do
    source "htaccess.erb"
    mode 0666
    owner "newspring"
    group "newspring"
  end

  link "#{node[:repo][:default][:destination]}/#{node[:ee][:main}/assets" do
    to "#{node[:repo][:default][:destination]}/#{m}/assets"
    link_type :symbolic
  end

  link "#{node[:repo][:default][:destination]}/#{node[:ee][:main}/themes" do
    to "#{node[:repo][:default][:destination]}/#{m}/themes"
    link_type :symbolic
  end

  #Create Vhost for each multisite
  web_app "#{cookie_domain}.frontend" do
    cookbook "apache2"
    template "apache.conf.erb"
    docroot "#{node[:repo][:default][:destination]}/#{cookie_domain}"
    vhost_port http_port
    server_name cookie_domain
    allow_override node[:web_apache][:allow_override]
    apache_log_dir node[:apache][:log_dir]
    notifies :restart, resources(:service => "apache2")
  end
end

