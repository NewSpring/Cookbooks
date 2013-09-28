package "aide" do
  action :install
end

# Always re-create the file, to fire a notification
file "#{node['aide']['config']}" do
  action :delete
end
template "#{node['aide']['config']}" do
  notifies :run, "script[generate_database]"
end

template "/etc/cron.d/aide" do
  action :create
  notifies :restart, "service[#{node['aide']['cron_service']}]"
end
service "#{node['aide']['cron_service']}" do
  action :nothing
end

ruby_block "Modify /etc/default/aide" do
  block do
    file = Chef::Util::FileEdit.new("/etc/default/aide")
    file.search_file_replace_line(
      "FQDN", "FQDN=\"NewSpring Church\"/n")

    file.search_file_replace_line(
      "MAILTO=root", "MAILTO=web@newspring.cc/n")

    file.search_file_replace_line(
      "COPYNEWDB=no", "COPYNEWDB=yes/n")

    file.search_file_replace_line(
      "#QUIETREPORTS=no", "QUIETREPORTS=yes/n")
  end
end

# Run by a notification from the template, so it happens at the end of
# the chef run, picking up all changes that were made
script "generate_database" do
  action :nothing
  interpreter "bash"
  unless node['aide']['testmode'] == "true"
    code "#{node['aide']['binary']} #{node['aide']['extra_parameters']} --init"
  end
end
