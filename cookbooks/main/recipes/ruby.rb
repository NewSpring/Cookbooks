rightscale_marker :begin

hubot "installing ruby gems" do
    body "  *** Installing rubygems!"
end

package "rubygems" do
  action :install
end

package "ruby-bundler" do
  action :install
end

domainatrix = chef_gem "domainatrix" do
  action :nothing
end

domainatrix.run_action(:install)

gem_package 'sass' do
  action :install
  version '3.2.11'
  options("--no-ri --no-rdoc")
end

gem_package 'rb-fsevent' do
  action :install
  version '0.9.3'
  options("--no-ri --no-rdoc")
end

gem_package 'coffee-script' do
  action :install
  version '2.2.0'
  options("--no-ri --no-rdoc")
end

gem_package 'rake' do
  action :install
  version '10.1.0'
  options("--no-ri --no-rdoc")
end

rightscale_marker :end
