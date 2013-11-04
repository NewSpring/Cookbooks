rightscale_marker :begin

ruby_block "Get Hostname" do
  block do
    if File.exists?("/etc/hostname")
      node.set[:cloud][:hostname] = File.open("/etc/hostname").read.strip
    else
      log "   HOSTNAME FILE DOESN'T EXIST!"
    end
  end
end

include_recipe "hipchat::default"

hipchat_msg "default" do
  token node[:hipchat][:token]
  room node[:hipchat][:room]
  nickname "RightScale"
  message "Added #{node[:cloud][:hostname]} to Load Balancer: #{node[:lb][:service][:lb_name]}."
  action :speak
end

rightscale_marker :end
