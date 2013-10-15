rightscale_marker :begin

include_recipe "hipchat::default"

hipchat_msg "default" do
  token node[:hipchat][:token]
  room node[:hipchat][:room]
  nickname "RightScale"
  message "Started Converging on #{node[:cloud][:public_ips][0]}."
  color "purple"
  action :speak
end

rightscale_marker :end

