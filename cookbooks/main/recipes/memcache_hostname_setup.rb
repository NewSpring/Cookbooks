rightscale_marker

search = "memcache_servers"

rightscale_server_collection search do
  tags "memcached_server:active=true"
  mandatory_tags "server:private_ip_0=*"
  action :load
end

ip_list = []
valid_ip_regex =
            '\b(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}' +
            '([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\b'

ip_list = node[:server_collection][search].collect do |_, tags|
  RightScale::Utils::Helper.get_tag_value("server:private_ip_0", tags, valid_ip_regex)
end

log "The tags are: #{ip_list[0]}"



#memcache_server_ip = RightScale::Utils::Helper.get_tag_value("server:private_ip_0", tags)
#log "The Memcached Server IP is: #{memcache_server_ip}"
