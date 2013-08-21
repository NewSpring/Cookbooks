include_recipe "hipchat"

hipchat_msg "added to lb" do
  room "Web Team"
  token node[:hipchat][:api_key]
  nickname "RightScale"
  message "Instance: #{node.rightscale.nickname}, has been removed from Load Balancer: #{node[:lb][:service][:lb_name]}"
  color "yellow"
end

