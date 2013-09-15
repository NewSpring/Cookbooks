maintainer       "NewSpring Church"
maintainer_email "web@newspring.cc"
license          "All rights reserved"
description      "Main cookbook for NewSpring Cloud Servers"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

depends "firewall"
depends "apt"
depends "rightscale"

recipe "main::apt", "Add PPA packages"
recipe "main::apache", "Disables default site and sets up ports"
recipe "main::added_to_lb", "Notifcation that instance was added to Load Balancer"
recipe "main::removed_from_lb", "Notification was removed from the Load Balancer"
recipe "main::add_auth_key", "Added Authorized Key"
recipe "main::ruby", "Install Ruby Stuffs"
recipe "main::memcache_hostname_setup", "Sets up a local memcache hostname to connect to the memcache instance on the deployment"
recipe "main::setup_firewall", "Sets up basic http/https firewall"
recipe "main::setup_postfix", "Setup up postfix service on MailGun"
recipe "main::lock_down_sudo", "Setup up postfix service on MailGun"
recipe "main::prevent_ip_spoofing", "Setup up postfix service on MailGun"


attribute "rightscale/public_key",
  :display_name => "Public Key",
  :description => "Public Key to simplify logging in",
  :required => "recommended",
  :recipes => [
    "main::add_auth_key"
  ]

# attribute "postfix/outgoing",
#   :display_name => "Outgoing Email Address",
#   :description => "Outgoing email address that connects to a SMTP server",
#   :required => "required",
#   :recipes => [
#     "main::setup_postfix"
#   ]
#
# attribute "postfix/password",
#   :display_name => "Outgoing SMTP Password",
#   :description => "Outgoing SMTP Password for the SMTP server",
#   :required => "recommended",
#   :recipes => [
#     "main::add_auth_key"
#   ]
