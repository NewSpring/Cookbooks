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

# Run by a notification from the template, so it happens at the end of
# the chef run, picking up all changes that were made
script "generate_database" do
  action :nothing
  interpreter "bash"
  unless node['aide']['testmode'] == "true"
    code "aideinit"
  end
end

ruby_block "edit_aide_default" do
   block do
    file = Chef::Util::FileEdit.new("/etc/default/aide")
    file.search_file_replace_line(
      "COPYNEWDB=no", "COPYNEWDB=yes")
    file.search_file_replace_line(
      "#QUIETREPORTS=no", "QUIETREPORTS=yes")
    file.search_file_replace_line(
      "MAILTO=root", "MAILTO=#{node[:apache][:contact]}")
    file.write_file
  end
end
