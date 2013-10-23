include_recipe "rightscale::default"

rightscale_marker :begin

search = "memcache_servers"

collection = server_collection search do
  tags "memcached_server:active=true"
  action :nothing
end

collection.run_action(:load)

ruby_block "Adding private IP of memcached server to config.php" do
  ip_list = []
  valid_ip_regex =
              '\b(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}' +
              '([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\b'

  ip_list = node[:server_collection][search].collect do |_, tags|
    RightScale::Utils::Helper.get_tag_value("server:private_ip_0", tags, valid_ip_regex)
  end

  block do
    file = Chef::Util::FileEdit.new("/var/www/newspring.cc/hello/expressionengine/config/config.php")
    file.search_file_replace_line(
      "memcached.private",
      "array( '#{ip_list[0]}', 11211, 1 )"
    )
    file.write_file

    file = Chef::Util::FileEdit.new("/etc/hosts")
    file.insert_line_if_no_match(
      "memcached.private",
      "#{ip_list[0]} memcached.private"
    )
    file.write_file
  end
end

service "apache2" do
  action :restart
end

right_link_tag "memcached_client:active=true"

rightscale_marker :end
