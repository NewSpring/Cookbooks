rightscale_marker

search = "memcache_servers"

rightscale_server_collection search do
  tags "memcached_server:active=true"
  mandatory_tags "server:private_ip_0=*"
  action :load
end

tags = node[:server_collection][search][0]
log "The tags are: #{tags}"

#memcache_server_ip = RightScale::Utils::Helper.get_tag_value("server:private_ip_0", tags)
#log "The Memcached Server IP is: #{memcache_server_ip}"
