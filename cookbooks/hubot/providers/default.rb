action :run do
  webroom = node[:hubot][:room] || new_resource.room
  message = new_resource.message
  url = node[:hubot][:url] || new_resource.url

  http_request "send_hubot_message" do
    action :post
    url url
    message { :message => "#{message}", :room => "#{webroom}" }
  end
end

