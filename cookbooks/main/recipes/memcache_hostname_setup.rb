include_recipe "rightscale::default"

memcache = rightscale_server_collection "memcache_servers" do
  tags "memcached_server:active=true"
  mandatory_tags "server:private_ip_0=*"
end

log "This is a log for memcache server #{memcache.inspect}"
