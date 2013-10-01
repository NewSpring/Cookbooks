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

sass = gem_package 'sass' do
  action :nothing
  version '3.2.11'
end

fsevent = gem_package 'rb-fsevent' do
  action :nothing
  version '0.9.3'
end

coffee = gem_package 'coffee-script' do
  action :nothing
  version '2.2.0'
end

rake = gem_package 'rake' do
  action :nothing
  version '10.1.0'
end

sass.run_action(:install)
fsevent.run_action(:install)
coffee.run_action(:install)
rake.run_action(:install)

rightscale_marker :end
