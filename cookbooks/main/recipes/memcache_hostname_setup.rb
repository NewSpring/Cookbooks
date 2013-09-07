rightscale_marker

search = "memcache_servers"

server_collection search do
  tags "memcached_server:active=true"
  action :load
end

log "Tags: #{node[:server_collection][search].inspect}"

#ruby_block "Installing Memcache Host..." do
#
#  ip_list = []
#  valid_ip_regex =
#              '\b(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}' +
#              '([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\b'
#
#  ip_list = node[:server_collection][search].collect do |_, tags|
#    RightScale::Utils::Helper.get_tag_value("server:private_ip_0", tags, valid_ip_regex)
#  end
#
#  block do
#    file = Chef::Util::FileEdit.new("/etc/hosts")
#    file.insert_line_if_no_match(
#      "# Memcache Private Server IP",
#      "\n# Memcache Private Server IP\n#{ip_list[0]}     memcache_host"
#    )
#    file.write_file
#  end
#end
