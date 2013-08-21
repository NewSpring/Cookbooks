name "hipchat"
maintainer "Cameron Johnston"
maintainer_email "cameron@rootdown.net"
description "LWRP for sending messages to HipChat rooms"
version "0.1.0"

recipe "hipchat::default", "Installed HipChat Gem within Chef"

attribute "hipchat/api_key",
  :display_name => "HipChat API Key",
  :description => "API Key for the HipChat Message Service, Only needs to be a notification API key.",
  :required => "required"
