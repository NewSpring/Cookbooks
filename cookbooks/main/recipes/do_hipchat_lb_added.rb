rightscale_marker :begin

hubot "added to loadbalancer" do
    body "  *** Added #{node[:cloud][:public_ips][0]} to Load Balancer: #{node[:lb][:service][:lb_name]}"
end

hubot "added to loadbalancer" do
    body "  *** Chef Run Complete!"
end


rightscale_marker :end
