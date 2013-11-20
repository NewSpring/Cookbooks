rightscale_marker :begin

bash "open-redis-port" do
  command "iptables -I FWR 4 -i eth1 -p tcp --dport #{node[:redisio][:port]} -j ACCEPT"
end

right_link_tag "redis_server:active=true"
right_link_tag "redis_server:port=#{node[:redisio][:port]}"

rightscale_marker :end
