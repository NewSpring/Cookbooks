package "ufw" do
  action :install
end

firewall "ufw" do
  action :nothing
end

#Don't get any ideas
