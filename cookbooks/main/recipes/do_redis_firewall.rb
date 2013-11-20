execute "open-redis-port" do
  command "iptables -I FWR 4 -i eth1 -p tcp --dport #{node[:redisio][:port]} -j ACCEPT"
end
