#rewriting so this could be run as an operational script in case we have to relaunch the memcache server for some reason

include_recipe "hostsfile::default"
include_recipe "rightscale::default"

rightscale_marker :begin

search = "memcache_servers"

collection = server_collection search do
  tags "memcached_server:active=true"
  action :nothing
end

collection.run_action(:load)

ruby_block "Installing Memcache Host..." do
  ip_list = []
  valid_ip_regex =
              '\b(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}' +
              '([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\b'

  ip_list = node[:server_collection][search].collect do |_, tags|
    RightScale::Utils::Helper.get_tag_value("server:private_ip_0", tags, valid_ip_regex)
  end

  block do
    hostsfile_entry ip_list[0] do
      hostname "memcache.private"
      unique true
      notifies :restart, "service[apache2]"
    end
  end
end

right_link_tag "memcached_client:active=true"

rightscale_marker :end
