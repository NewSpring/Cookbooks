include_recipe "datadog::dd-agent"

# Integrate memcache metrics into Datadog
#
# Simply set up attributes following this example.
# If you are running multiple memcache instances on the same machine
# list them all as hashes.

instance = [
 {
   "url" => node[:cloud][:private_ips][0],
   "port" => node['datadog']['memcache']['port']
 }
]

rightscale_marker :begin

package 'python-memcache' do
  action :install
end

datadog_monitor "mcache" do
  instances instance
end

rightscale_marker :end
