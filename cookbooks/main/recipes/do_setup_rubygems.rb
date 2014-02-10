rightscale_marker :begin

%w{ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev ruby-bundler}.each do |p|
  package "#{p}" do
    action :install
  end
end

domainatrix = chef_gem "domainatrix" do
  action :nothing
end

domainatrix.run_action(:install)

node[:rubygems][:list].each do |gem|
  execute "install_#{gem}" do
    command "gem install #{gem} --no-ri --no-rdoc"
  end
end

rightscale_marker :end
