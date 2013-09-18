file "/etc/mailname" do
  mode "644"
  user "root"
  group "root"
  action :create_if_missing
  content "newspring.cc"
end
