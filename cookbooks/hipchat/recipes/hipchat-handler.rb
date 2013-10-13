include_recipe "chef_handler"

# handler_file = cookbook_file "#{node['chef_handler']['handler_path']}/hipchat_handler.rb" do
#   source "hipchat_handler.rb"
#   mode "0600"
#   action :nothing
# end
#
# handler_file.run_action(:create)

require 'hipchat/chef'

chef_handler "HipChat::NotifyRoom" do
  source 'hipchat/chef'
  arguments ["",{
    :api_token => node[:hipchat][:token],
    :room_name => node[:hipchat][:room],
    :notify_users => true,
    :report_success => true
  }]
  action :nothing
end.run_action(:enable)
