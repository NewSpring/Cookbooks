include_recipe "app::do_server_restart"


include_recipe "hipchat::default"

hipchat_msg "default" do
  token node[:hipchat][:token]
  room node[:hipchat][:room]
  nickname "RightScale"
  message "Rebooted Apache"
  color "green"
  action :speak
end

