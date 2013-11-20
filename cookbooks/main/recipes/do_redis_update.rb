#
# Cookbook Name:: main
# Recipe:: do_redis_update
#
# Copyright 2012, NewSpring Church
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rightscale::default"
rightscale_marker :begin

search = "redis_servers"

collection = server_collection search do
  tags "redis_server:active=true"
  action :nothing
end

collection.run_action(:load)

ruby_block "Updating the private IP of redis server to config.php" do
  ip_list = []
  valid_ip_regex =
              '\b(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}' +
              '([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\b'

  ip_list = node[:server_collection][search].collect do |_, tags|
    RightScale::Utils::Helper.get_tag_value("server:private_ip_0", tags, valid_ip_regex)
  end

  port = node[:server_collection][search].collect do |_, tags|
    RightScale::Utils::Helper.get_tag_value("redis_server:port", tags)
  end


  block do
    file = Chef::Util::FileEdit.new("/var/www/newspring.cc/hello/expressionengine/config/config.php")
    file.search_file_replace_line(
      /'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'\:\d{4}/,
      "array( '#{ip_list[0]}:#{port[0]}' )"
    )
    file.write_file

    file = Chef::Util::FileEdit.new("/etc/hosts")
    file.search_file_replace_line(
      "redis.private",
      "#{ip_list[0]} redis.private"
    )
    file.write_file

  end
end

service "apache2" do
  action :restart
end

right_link_tag "redis_client:active=true"

rightscale_marker :end
