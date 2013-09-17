maintainer       "First Banco"
maintainer_email "rob@firstbanco.com"
license          "All rights reserved"
description      "Installs/Configures papertrail"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
depends         "build-essential"

supports "ubuntu"
supports "debian"

recipe "papertrail::default", "Installs the Configuration to send logs to the papertrail app service"

attribute "papertrail/logs",
  :display_name => "Log Files",
  :description => "Select with log files to send",
  :required => "required",
  :type => "array",
  :recipes => [
    "papertrail::default"
  ]

  attribute "papertrail/host",
  :display_name => "Papertrail Host",
  :description => "Hostname for Papertrail Service",
  :default => "logs.papertrailapp.com",
  :recipes => [
    "papertrail::default"
  ]

  attribute "papertrail/port",
  :display_name => "Papertrail Port",
  :description => "Port for Papertrail Service",
  :required => "required",
  :recipes => [
    "papertrail::default"
  ]

  attribute "papertrail/exclude_patterns",
  :display_name => "Exclude Patterns",
  :description => "Pattern Regex to Exclude",
  :recipes => [
    "papertrail::default"
  ]
