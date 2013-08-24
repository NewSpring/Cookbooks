rightscale_marker :begin

include_recipe "hipchat"

hipchat_msg "added to lb" do
  room "Web Team"
  token node[:hipchat][:api_key]
  nickname "RightScale"
  message "Instance: #{node[:cloud][:public_ips][0]}, has been added to Load Balancer: #{node[:lb][:service][:lb_name]}"
  color "green"
end

rightscale_marker :end
