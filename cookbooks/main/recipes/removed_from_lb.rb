rightscale_marker :begin

include_recipe "hipchat"

log" HOSTNAME: #{node[:cloud][:hostname]}"
log" SERVERNAME: #{node[:cloud][:server_name]}"
log" NAME: #{node[:cloud][:name]}"

hipchat_msg "added to lb" do
  room node[:hipchat][:room]
  token node[:hipchat][:api_key]
  nickname "RightScale"
  message "Instance: #{node[:cloud][:public_ips][0]}, has been removed from Load Balancer: #{node[:lb][:service][:lb_name]}"
  color "purple"
end

rightscale_marker :end
