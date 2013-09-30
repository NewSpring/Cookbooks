rightscale_marker :begin

hubot "installing ruby gems" do
    body "  *** Installing Rubygems!"
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

execute "install_sass" do
  command "gem install sass --no-ri --no-rdoc"
  not_if "`which sass`"
end

execute "install_coffeescript" do
  command "gem install coffee-script --no-ri --no-rdoc"
  not_if "`which coffee`"
end

execute "install_rb-fsevent" do
  command "gem install rb-fsevent --no-ri --no-rdoc"
end

execute "install_rake" do
  command "gem install rake --no-ri --no-rdoc"
  not_if "`which rake`"
end


rightscale_marker :end
