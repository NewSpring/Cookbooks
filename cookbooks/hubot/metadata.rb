name             'hubot'
maintainer       'NewSpring Church'
maintainer_email 'drew.delianides@newspring.cc'
license          'All rights reserved'
description      'Installs/Configures hubot'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "hubot::default", "Initializes the resource"

attribute "hubot/webhook",
  :display_name => "Hubot Webhook URL",
  :description => "The webhook url that should be posted too?",
  :required => "required",
  :recipes => [
    "hubot::default"
  ]

attribute "hubot/room",
  :display_name => "Hubot Webhook Room",
  :description => "Room Hubot Should Speak In",
  :required => "required",
  :recipes => [
    "hubot::default"
  ]
