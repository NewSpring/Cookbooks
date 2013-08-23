rightscale_marker :begin

file "/root/.ssh" do
  owner "root"
  group "root"
  mode "644"
  action :create
  content node[:rightscale][:public_key]
end

rightscale_marker :end
