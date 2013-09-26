rightscale_marker :begin

http_request "do start notify" do
  action :post
  url "http://apollos.herokuapp.com/apollos/rightscale"
  message :message => "Starting to set this beyotch up!", :room => "21097_newspring_church@conf.hipchat.com"
end

rightscale_marker :end
