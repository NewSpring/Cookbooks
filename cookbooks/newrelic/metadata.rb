maintainer       "NewSpring Church"
maintainer_email "web@newspring.cc"
license          "All rights reserved"
description      "Installs/Configures newrelic"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends          'apt'
depends          'build-essential'
depends          'python'
depends          'apache2'

%w{ ubuntu debian }.each do |os|
  supports os
end

recipe "newrelic::default", "Installs the PHP NewRelic Agent"

attribute "newrelic/enabled",
  :display_name => "Enabled NewRelic",
  :description => "Whether or not NewRelic should be enabled",
  :choice => ["true", "false"],
  :default => "true",
  :recipes => [
    "newrelic::default"
  ]

attribute "newrelic/license_key",
  :display_name => "NewRelic License Key",
  :description => "NewRelic License Key to connect monitoring to your account",
  :required => "required",
  :recipes => [
    "newrelic::default"
  ]

attribute "newrelic/log_location",
  :display_name => "Log Location",
  :description => "Where should the NewRelic Log be located?",
  :default => "/var/log/newrelic/php_agent.log",
  :recipes => [
    "newrelic::default"
  ]

attribute "newrelic/log_level",
  :display_name => "NewRelic PHP Agent Log Level",
  :description => "The level of reporting set for the PHP Agent",
  :default => "info",
  :choice => ["always","error","warning","info","verbose","debug","verbosedebug"],
  :recipes => [
    "newrelic::default"
  ]

attribute "newrelic/app_name",
  :display_name => "App Name",
  :description => "Name of the PHP App in NewRelic",
  :default => "PHP Application",
  :required => "recommended",
  :recipes => [
    "newrelic::default"
  ]
