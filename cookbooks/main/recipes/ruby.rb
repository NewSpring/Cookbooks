rightscale_marker :begin

package "ruby-bundler" do
  action :install
end

domainatrix = chef_gem "domainatrix" do
  action :nothing
end

domainatrix.run_action(:install)

execute "install_sass" do
  command "gem install sass --no-ri --no-rdoc"
  not_if "`which sass`"
end

execute "install_coffeescript" do
  command "gem install coffeescript --no-ri --no-rdoc"
  not_if "`which coffee`"
end

execute "install_rake" do
  command "gem install rake --no-ri --no-rdoc --version"
  not_if "`which rake`"
end

rightscale_marker :end
