maintainer       "NewSpring Church"
maintainer_email "web@newspring.cc"
license          "All rights reserved"
description      "Main cookbook for NewSpring Cloud Servers"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.5.0"

depends "apt"
depends "php"
depends "rightscale"

recipe "main::do_php_apt_repo", "Add PPA packages"
recipe "main::do_apache_configure", "Disables default site and sets up ports"
recipe "main::do_hipchat_lb_added", "Notifcation that instance was added to Load Balancer"
recipe "main::do_hipchat_lb_removed", "Notification was removed from the Load Balancer"
recipe "main::do_auth_key", "Added Authorized Key"
recipe "main::do_setup_rubygems", "Install Ruby Stuffs"
recipe "main::do_memcache_setup", "Sets up a local memcache hostname to connect to the memcache instance on the deployment"
recipe "main::do_prevent_ip_spoof", "Prevent IP Spoofing"
recipe "main::do_add_mailname", "Add Mailname for Postfix"
recipe "main::do_harden_php", "PHP Hardening"
recipe "main::do_harden_sysctl", "Harden Network Settings"
recipe "main::do_hipchat_start_notify", "Notify Apollos that setup has started"
recipe "main::do_set_php_timezone", "Set the PHP TimeZone"
recipe "main::do_apc_setup", "Configure APC Caching"

recipe "main::do_cache_on", "Turn Caching On"
recipe "main::do_cache_off", "Turn Caching Off"


attribute "rightscale/public_key",
  :display_name => "Public Key",
  :description => "Public Key to simplify logging in",
  :required => "recommended",
  :recipes => [
    "main::do_auth_key"
  ]
