package "ruby-bundler" do
  action :install
end

domainatrix = chef_gem "domainatrix" do
  action :nothing
end

domainatrix.run_action(:install)

execute "install_sass" do
  command "gem install sass --no-ri --no-rdoc --version '> 3.2.11'"
  not_if "`which sass`"
end

execute "install_coffeescript" do
  command "gem install coffeescript --no-ri --no-rdoc --version '> 2.2.0'"
  not_if "`which coffee`"
end
