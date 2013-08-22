#hipchat = gem_package 'hipchat' do
#  action :nothing
#  version "0.11.0"
#end
#
#hipchat.run_action(:install)
#
execute "Install HipChat API" do
  command "gem install hipchat"
end
