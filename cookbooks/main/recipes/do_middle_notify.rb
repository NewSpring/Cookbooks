rightscale_marker :begin

http_request "do middle notify" do
  action :post
  url "http://apollos.herokuapp.com/apollos/rightscale"
  message :message => "Whoa Whoa Whoa! Be Patient, almost done!", :room => "21097_newspring_church@conf.hipchat.com"
end

rightscale_marker :end
