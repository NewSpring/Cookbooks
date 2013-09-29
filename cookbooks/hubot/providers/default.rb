action :run do
  room = node[:hubot][:room] || new_resource.room
  message = { :message => "#{message}", :room => "#{room}" }
  webhook = node[:hubot][:url] || new_resource.url

  http_request "send_hubot_message" do
    action :post
    url "#{webhook}"
    message message
  end
end

