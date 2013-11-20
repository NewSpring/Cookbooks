rightscale_marker :begin

sys_firewall "redis" do
  port 6379
  enable true
  ip_tag "server:private_ip_0"
  action :update
end

right_link_tag "redis_server:active=true"
right_link_tag "redis_server:port=#{node[:redisio][:port]}"

rightscale_marker :end
