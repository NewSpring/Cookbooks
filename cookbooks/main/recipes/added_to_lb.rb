rightscale_marker :begin

include_recipe "hipchat"

# Logs 'node[:rightscale][:servers][:sketchy][:hostname]'.
# Raises an Exception if it isn't set.
if node[:rightscale][:servers][:sketchy][:hostname].to_s.empty?
  raise "'node[:rightscale][:servers][:sketchy][:hostname]' must be set!"
else
  log "  Sketchy hostname: #{node[:cloud].inspect}"
  hostname = node[:rightscale][:servers][:sketchy][:hostname]
end

hipchat_msg "added to lb" do
  room "Web Team"
  token node[:hipchat][:api_key]
  nickname "RightScale"
  message "Instance: #{hostname}, has been added to Load Balancer: #{node[:lb][:service][:lb_name]}"
  color "green"
end

rightscale_marker :end
