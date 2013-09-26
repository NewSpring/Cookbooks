rightscale_marker :begin

http_request "do end notify" do
  action :post
  url "http://apollos.herokuapp.com/apollos/rightscale"
  message :message => "New server is all setup! You're welcome!", :room => "21097_newspring_church@conf.hipchat.com"
end

rightscale_marker :end
