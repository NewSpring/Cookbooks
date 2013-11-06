apache_site "#{node[:ee][:disable]}.frontend.conf" do
  enable false
end
