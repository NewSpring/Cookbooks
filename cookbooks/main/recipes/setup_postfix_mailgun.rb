rightscale_marker :begin

template "/etc/postfix/main.cf" do
  source "main.cf.erb"
  mode 0666
  owner "root"
  group "root"
end

rightscale_marker :end
