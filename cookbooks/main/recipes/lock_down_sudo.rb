rightscale_marker :begin

user "webuser" do
  comment "Standard Web User"
  home "/home/webuser"
end

group "admin" do
  gid 999
  members ['webuser']
end

execute "lock_su" do
  user "root"
  code <<-EOH
    dpkg-statoverride --update --add root admin 4750 /bin/su
  EOH

  not_if { ::File.exists? '[/bin/su]' }
end

rightscale_marker :end

