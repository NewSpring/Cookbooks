name              "fail2ban"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs and configures fail2ban"
version           "1.2.5"

recipe "fail2ban::default", "Installs and configures fail2ban"

depends "yum"

%w{ debian ubuntu redhat centos fedora scientific amazon oracle }.each do |os|
  supports os
end

attribute 'fail2ban/loglevel',
  :display_name => "Log Level",
  :description => "What log level should fail2ban be set at?",
  :default => "3",
  :recipes => [
    "fail2ban::default"
  ]

attribute 'fail2ban/syslog_facility',
  :display_name => "Syslog Facility",
  :description => "Syslog Facility",
  :default => "1",
  :recipes => [
    "fail2ban::default"
  ]


attribute 'fail2ban/socket',
  :display_name => "Socket Location",
  :description => "Socket Location",
  :default => "/var/run/fail2ban/fail2ban.sock",
  :recipes => [
    "fail2ban::default"
  ]

attribute 'fail2ban/logtarget',
  :display_name => "Log File",
  :description => "Location of the log file to output too?",
  :default => "/var/log/fail2ban.log",
  :recipes => [
    "fail2ban::default"
  ]

attribute 'fail2ban/syslog_target',
  :display_name => "Syslog Target File",
  :description => "Syslog Target File?",
  :default => "/var/log/fail2ban.log",
  :recipes => [
    "fail2ban::default"
  ]

attribute 'fail2ban/bantime',
  :display_name => "Bantime",
  :description => "How long should someone be banned?",
  :default => "300",
  :recipes => [
    "fail2ban::default"
  ]

attribute 'fail2ban/maxretry',
  :display_name => "Max Retry",
  :description => "How many attempts till someone his banned?",
  :default => "5",
  :recipes => [
    "fail2ban::default"
  ]

attribute 'fail2ban/maxretry',
  :display_name => "Max Retry",
  :description => "How many attempts till someone his banned?",
  :default => "5",
  :recipes => [
    "fail2ban::default"
  ]

attribute 'fail2ban/email',
  :display_name => "Email Address",
  :description => "Email Address to Notify",
  :default => "root@localhost",
  :recipes => [
    "fail2ban::default"
  ]

attribute 'fail2ban/banaction',
  :display_name => "How to Ban?",
  :description => "The method of banning a user?",
  :default => "5",
  :recipes => [
    "fail2ban::default"
  ]

attribute 'fail2ban/banaction',
  :display_name => "How to Ban?",
  :description => "The method of banning a user?",
  :default => "5",
  :recipes => [
    "fail2ban::default"
  ]

attribute 'fail2ban/mta',
  :display_name => "Mail Method",
  :description => "How should the mail be sent?",
  :default => "postfix",
  :recipes => [
    "fail2ban::default",
  ]



