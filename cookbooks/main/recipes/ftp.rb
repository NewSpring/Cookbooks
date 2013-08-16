#Install vsftpd
package "vsftpd" do
  action :install
end

template "/etc/vsftpd.conf" do
  source "vsftpd.conf.erb"
  owner "root"
  group "root"
  mode "0544"
end

execute "ftp-start" do
  command "/etc/init.d/vsftpd restart"
  action :run
end

