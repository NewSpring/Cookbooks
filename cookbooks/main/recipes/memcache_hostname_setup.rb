rightscale_marker

include_recipe "rightscale::default"

rightscale_server_collection "memcache_servers" do
  tags "memcached_server:active=true"
  mandatory_tags "server:private_ip_0=*"
  action :load
end

log "This is a log for memcache server #{node[:server_collection].inspect}"
