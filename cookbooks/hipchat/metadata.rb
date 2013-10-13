name             'hipchat'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures hipchat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "chef_handler"

recipe "hipchat::default", "Installs the HipChat Gem"
recipe "hipchat::hipchat_handler", "Sets up the Chef Reporting Handler to HipChat"

attribute "hipchat/token",
  :display_name => "API Token",
  :description => "Notification token to the HipChat API",
  :required => "required",
  :recipes => [
    "hipchat::default",
    "hipchat::hipchat_hander"
  ]

attribute "hipchat/room",
  :display_name => "Reporting Room",
  :description => "The room that should receive the report",
  :required => "required",
  :recipes => [
     "hipchat::default",
    "hipchat::hipchat_hander"
  ]

attribute "hipchat/notify",
  :display_name => "Notify Users",
  :description => "Should the notification notify all users?",
  :choice => ["true", "false"],
  :default => "true",
  :recipes => [
     "hipchat::default",
    "hipchat::hipchat_hander"
  ]

