require 'domainatrix'

http_port = "80"

node[:ee][:multisite].each do |m|

  domain = Domainatrix.parse(m)

  if domain.subdomain == ""
    site_name = domain.domain
    cookie_domain = "#{domain.domain}.#{domain.public_suffix}"
    server_alias = "www.#{domain.domain}.#{domain.public_suffix}"
  else
    if domain.subdomain == "dev" || domain.subdomain == "beta" || domain.subdomain == "staging"
      site_name = domain.domain
    else
      site_name = domain.subdomain
    end
    cookie_domain = "#{domain.subdomain}.#{domain.domain}.#{domain.public_suffix}"
    server_alias = cookie_domain
  end

  directory "#{node[:repo][:default][:destination]}/#{cookie_domain}" do
    owner node[:web_apache][:application_name]
    group node[:web_apache][:application_name]
    mode 0775
    action :create
  end

  directory "#{node[:repo][:default][:destination]}/#{cookie_domain}/images" do
    owner node[:web_apache][:application_name]
    group node[:web_apache][:application_name]
    mode 0777
    action :create
  end

  template "#{node[:repo][:default][:destination]}/#{cookie_domain}/index.php" do
    source "index.php.erb"
    mode 0666
    owner node[:web_apache][:application_name]
    group node[:web_apache][:application_name]
    variables({
      :site_name => "#{site_name}",
      :site_url => "#{domain.url}",
      :cookie_domain => "#{cookie_domain}"
    })
  end

  template "#{node[:repo][:default][:destination]}/#{cookie_domain}/admin.php" do
    source "admin.php.erb"
    mode 0666
    owner node[:web_apache][:application_name]
    group node[:web_apache][:application_name]
    variables({
      :site_name => "#{site_name}",
      :site_url => "#{domain.url}",
      :cookie_domain => "#{cookie_domain}"
    })
  end

  template "#{node[:repo][:default][:destination]}/#{cookie_domain}/.htaccess" do
    source "htaccess.erb"
    mode 0666
    owner node[:web_apache][:application_name]
    group node[:web_apache][:application_name]
  end

  link "#{node[:repo][:default][:destination]}/#{cookie_domain}/assets" do
    to "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}/assets"
    link_type :symbolic
    action :create
  end

  link "#{node[:repo][:default][:destination]}/#{cookie_domain}/themes" do
    to "#{node[:repo][:default][:destination]}/#{node[:ee][:main]}/themes"
    link_type :symbolic
    action :create
  end

  #Create Vhost for each multisite
  web_app "#{cookie_domain}.frontend" do
    cookbook "apache2"
    template "web_app.conf.erb"
    docroot "#{node[:repo][:default][:destination]}/#{cookie_domain}"
    vhost_port http_port
    server_name cookie_domain
    server_aliases server_alias
    allow_override node[:web_apache][:allow_override]
    apache_log_dir node[:apache][:log_dir]
  end
end

