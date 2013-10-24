apt_repository 'newrelic' do
  uri          node['newrelic']['apt']['repo']['url']
  distribution node['newrelic']['apt']['repo']['distribution']
  components   node['newrelic']['apt']['repo']['components']
  key          node['newrelic']['apt']['repo']['key']
  only_if    { node['platform_family'] == 'debian' }
end

package 'newrelic-php5'

template "/etc/php5/conf.d/newrelic.ini" do
  source "newrelic.ini.erb"
  mode 0644
  notifies :restart, "service[apache2]"
end

