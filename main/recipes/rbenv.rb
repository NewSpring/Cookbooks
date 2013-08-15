#Install Ruby
rbenv_ruby "1.9.3-p362" do
  global true
end

rbenv_gem "rails" do 
  action :install
end
