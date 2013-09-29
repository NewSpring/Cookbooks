action :run do
  if new_resource.room.empty?
    room = node[:hubot][:room]
  else
    room = new_resource.room
  end

  hubot = http_request "do start notify" do
    action :post
    url node[:hubot][:url] ||= new_resource.url
    message :message => "#{new_resource.message}", :room => "#{room}"
  end
end

