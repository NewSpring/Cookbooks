rightscale_marker :begin

include_recipe "hipchat::default"

hipchat_msg "default" do
  token node[:hipchat][:token]
  room node[:hipchat][:room]
  nickname "RightScale"
  message "Added #{node[:cloud][:hostname]} to Load Balancer: #{node[:lb][:service][:lb_name]}."
  action :speak
end

rightscale_marker :end
