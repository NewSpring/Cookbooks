file "/etc/mailname" do
  mode "644"
  user "root"
  group "root"
  action :create_if_mission
  content "newspring.cc"
end
