maintainer       "NewSpring Church"
maintainer_email "web@newspring.cc"
license          "All rights reserved"
description      "Main cookbook for NewSpring Cloud Servers"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.5.0"

depends "apt"
depends "php"
depends "rightscale"
depends "hipchat"
depends "apache2"
depends "sys_firewall"
depends "iptables"

recipe "main::do_php_apt_repo", "Add PPA packages"
recipe "main::do_apache_configure", "Disables default site and sets up ports"
recipe "main::do_php_configure", "Sets up PHP POST and Upload values"
recipe "main::do_hipchat_lb_added", "Notifcation that instance was added to Load Balancer"
recipe "main::do_hipchat_lb_removed", "Notification was removed from the Load Balancer"
recipe "main::do_auth_key", "Added Authorized Key"
recipe "main::do_setup_rubygems", "Install Ruby Stuffs"
recipe "main::do_memcache_setup", "Adds the private IP to the config.php file"
recipe "main::do_memcache_update", "Updates the private IP to the config.php file incase the memcache server needs to be relaunched"
recipe "main::do_prevent_ip_spoof", "Prevent IP Spoofing"
recipe "main::do_add_mailname", "Add Mailname for Postfix"
recipe "main::do_harden_php", "PHP Hardening"
recipe "main::do_harden_sysctl", "Harden Network Settings"
recipe "main::do_hipchat_start_notify", "Notify Apollos that setup has started"
recipe "main::do_set_php_timezone", "Set the PHP TimeZone"
recipe "main::do_apc_setup", "Configure APC Caching"
recipe "main::do_redis_setup", "Configure Redis PHP Client"
recipe "main::do_redis_firewall", "Configure Redis Firewall for Redis Server"
recipe "main::do_redis_update", "Update Redis Configuration"

recipe "main::do_vpn_connect", "Setup NewSpring VPN Connection"

recipe "main::do_reboot_apache", "Reboot Apache"

recipe "main::do_cache_on", "Turn Caching On"
recipe "main::do_cache_off", "Turn Caching Off"


attribute "newrelic-ng/license_key",
  :display_name => "NewRelic License Key",
  :description => "The NewRelic License Key Tied to your account",
  :required => "required",
  :recipes => [
    "main::do_setup_newrelic_monitoring",
    "main::do_setup_newrelic_php",
    "main::do_setup_newrelic_memcache",
    "main::do_setup_newrelic_apache",
    "main::do_setup_newrelic_apc"
  ]

attribute "rightscale/public_key",
  :display_name => "Public Key",
  :description => "Public Key to simplify logging in",
  :required => "recommended",
  :recipes => [
    "main::do_auth_key"
  ]

attribute "hipchat/token",
  :display_name => "API Token",
  :description => "Notification token to the HipChat API",
  :required => "required",
  :recipes => [
    "main::do_hipchat_lb_added",
    "main::do_hipchat_lb_removed",
    "main::do_hipchat_start_notify"
  ]

attribute "hipchat/room",
  :display_name => "Reporting Room",
  :description => "The room that should receive the report",
  :required => "required",
  :recipes => [
    "main::do_hipchat_lb_added",
    "main::do_hipchat_lb_removed",
    "main::do_hipchat_start_notify"
  ]

attribute "hipchat/notify",
  :display_name => "Notify Users",
  :description => "Should the notification notify all users?",
  :choice => ["true", "false"],
  :default => "true",
  :recipes => [
    "main::do_hipchat_lb_added",
    "main::do_hipchat_lb_removed",
    "main::do_hipchat_start_notify"
  ]

attribute "vpn/hostname",
  :display_name => "Hostname of the VPN",
  :description => "Enter the hostname of the vpn server that you want to connect to",
  :required => "required",
  :recipes => [
    "main::do_vpn_connect"
  ]

attribute "vpn/username",
  :display_name => "VPN Username",
  :description => "Username to access the VPN",
  :required => "required",
  :recipes => [
    "main::do_vpn_connect"
  ]

attribute "vpn/password",
  :display_name => "VPN Password",
  :description => "Password to Access the VPN",
  :required => "required",
  :recipes => [
    "main::do_vpn_connect"
  ]

attribute "rubygems/list",
  :display_name => "Ruby Gems",
  :description => "Array of Ruby Gems to Install",
  :required => "recommended",
  :recipes => [
    "main::do_setup_rubygems"
  ]
