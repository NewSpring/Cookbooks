remote_syslog = gem_package "remote_syslog" do
  action :nothing
end

remote_syslog.run_action(:install)
