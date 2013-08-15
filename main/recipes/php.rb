package "php5-mysql" do
  action :install
end

package "php5-gd" do 
  action :install
end

package "php5-curl" do
  action :install
end

package "php-pear" do
  action :install 
end

package "php5-dev" do
  action :install
end

package "libpcre3-dev" do
  action :install
end

php_pear "oauth" do
  action :install
end
