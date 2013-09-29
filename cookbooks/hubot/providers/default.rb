action :run do
  room = new_resource.room || node[:hubot][:room]
  message = { :message => "#{message}", :room => "#{room}" }
  webhook = new_resource.url || node[:hubot][:url]

  log "  ROOM: #{room}"
  log "  MESSAGE: #{message}"
  log "  URL: #{webhook}"

  http_request "send_hubot_message" do
    action :post
    url "#{webhook}"
    message message
  end
end

