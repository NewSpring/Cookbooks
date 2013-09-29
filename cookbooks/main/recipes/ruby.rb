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
  command "gem install sass --no-ri --no-rdoc"
  not_if "`which coffee`"
end
