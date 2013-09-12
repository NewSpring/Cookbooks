maintainer       "Blue Box Group, LLC"
maintainer_email "support@bluebox.net"
license          "Apache 2.0"
description      "Installs/Configures remote_syslog"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.0"
name             "remote_syslog"

recipe "remote_syslog::default", ""
recipe "remote_syslog::install", "Runs Gem, Configure and Service recipes"
recipe "remote_syslog::configure", "Configures the YAML file"
recipe "remote_syslog::gem", "Installs the remote_syslog gem"
recipe "remote_syslog::service", "creates the init file in /etc/init.d"

attribute "remote_syslog/init_style",
  :display_name => "Init Style",
  :description => "How to configure the remote_syslog service",
  :default => "init",
  :recipes => [
    "remote_syslog::install",
    "remote_syslog::service"
  ]

attribute "remote_syslog/conf/files",
  :display_name => "Log Files",
  :description => "Select which log files remote_syslog should process",
  :required => "optional",
  :type => "array",
  :recipes => [
    "remote_syslog::install",
    "remote_syslog::configure"
  ]

attribute "remote_syslog/destination/host",
  :display_name => "Host for Remote Destination",
  :description => "Remote FQDN for where the logs should be sent",
  :default => "logs.papertrailapp.com",
  :recipes => [
    "remote_syslog::install",
    "remote_syslog::configure",
    "remote_syslog::service"
  ]

attribute "remote_syslog/destination/port",
  :display_name => "Port for Remote Destination",
  :description => "Remote port for where the logs should be send",
  :required => "required",
  :recipes => [
    "remote_syslog::install",
    "remote_syslog::configure",
    "remote_syslog::service"
  ]

attribute "remote_syslog/exclude_files",
  :display_name => "Exclude Files",
  :description => "Exclude and do not send these files",
  :required => "optional",
  :recipes => [
    "remote_syslog::install",
    "remote_syslog::service",
    "remote_syslog::configure"
  ]




