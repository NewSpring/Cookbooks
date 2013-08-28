maintainer       "NewSpring Church"
maintainer_email "web@newspring.cc"
license          "All rights reserved"
description      "Main cookbook for NewSpring Cloud Servers"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

depends "firewall"
depends "apt"

recipe "main::apt", "Add PPA packages"
recipe "main::added_to_lb", "Notifcation that instance was added to Load Balancer"
recipe "main::removed_from_lb", "Notification was removed from the Load Balancer"
recipe "main::add_auth_key", "Added Authorized Key"
recipe "main::ruby", "Install Ruby Stuffs"


attribute "rightscale/public_key",
  :display_name => "Public Key",
  :description => "Public Key to simplify logging in",
  :required => "recommended",
  :recipes => [
    "main::add_auth_key"
  ]
