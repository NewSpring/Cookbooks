apache_site "#{node[:ee][:disable]}.frontend.conf" do
  action :disable
end
