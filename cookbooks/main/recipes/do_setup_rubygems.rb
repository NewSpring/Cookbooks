rightscale_marker :begin

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

node[:rubygems][:list].each do |gem|
  execute "install_#{gem}" do
    command "gem install #{gem} --no-ri --no-rdoc"
  end
end

rightscale_marker :end
