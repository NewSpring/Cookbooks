rightscale_marker :begin

hubot "removed from loadbalancer" do
    body "  *** Removed #{node[:cloud][:public_ips][0]} from Load Balancer: #{node[:lb][:service][:lb_name]}"
end

rightscale_marker :end
