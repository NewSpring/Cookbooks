rightscale_marker :begin

include_recipe "hipchat::default"

hipchat_msg "default" do
  room "Deployment"
  nickname "RightScale"
  message "Added #{node[:cloud][:public_ips][0]} to Load Balancer: #{node[:lb][:service][:lb_name]}."
  action :speak
end

rightscale_marker :end
