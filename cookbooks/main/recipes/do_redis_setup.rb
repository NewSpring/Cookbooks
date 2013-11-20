php_pear "redis" do
  action :install
end

file "/etc/php5/apache2/conf.d/redis.ini" do
  content "extension=redis.so"
  mode "644"
  owner "root"
  group "root"
end
