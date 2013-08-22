hipchat = chef_gem 'hipchat' do
 action :nothing
end

hipchat.run_action(:install)
#
#execute "Install HipChat API" do
#  command "gem install hipchat"
#end
