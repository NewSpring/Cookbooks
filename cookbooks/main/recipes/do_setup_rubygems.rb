rightscale_marker :begin

%w{ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev ruby-bundler}.each do |p|
  package "#{p}" do
    action :install
  end
end

#dominatrix is only used during chef run to parse out the multisite information
domainatrix = chef_gem "domainatrix" do
  action :nothing
end

domainatrix.run_action(:install)

execute "install-rubygems-update" do
  command "gem install rubygems-update --no-ri --no-rdoc"
  notifies :run, "execute[run-rubygems-update]"
end

execute "run-rubygems-update" do
  command "update_rubygems"
  user "root"
  action :nothing
  notifies :run, "execute[install-bundler]"
end

execute "install-bundler" do
  command "gem install bundler -f --no-fdoc --no-ri"
  action :nothing
end

#install gems from attributes
node[:rubygems][:list].each do |gem|
  execute "install_#{gem}" do
    command "gem install #{gem} --no-ri --no-rdoc"
  end
end

rightscale_marker :end
