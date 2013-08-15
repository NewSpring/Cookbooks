apache_module "vhost_alias" do
  enable true
end

apache_module "version" do 
  enable true 
end

apache_module "suexec" do 
  enable true
end

apache_module "cache" do
  enable true
end

apache_module "userdir" do
  enable true
end
