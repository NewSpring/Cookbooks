hipchat = gem_package 'hipchat' do
  action :nothing
  version "0.11.0"
end

hipchat.run_action(:install)
