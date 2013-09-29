action :run do
  webhook = new_resource.url || node[:hubot][:webhook]

  message = {}
  message[:body] = new_resource.body
  message[:room] = new_resource.room || node[:hubot][:room]

  http_request "default" do
    action :post
    url webhook
    message message
  end
end

