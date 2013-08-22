include_recipe "hipchat"

log" HOSTNAME: #{node[:cloud][:hostname]}"
log" SERVERNAME: #{node[:cloud][:server_name]}"
log" NAME: #{node[:cloud][:name]}"

hipchat_msg "added to lb" do
  room "Web Team"
  token node[:hipchat][:api_key]
  nickname "RightScale"
  message "Instance: #{node[:cloud][:hostname]}, has been removed from Load Balancer: #{node[:lb][:service][:lb_name]}"
  color "yellow"
end

