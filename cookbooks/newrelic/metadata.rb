maintainer       "NewSpring Church"
maintainer_email "web@newspring.cc"
license          "All rights reserved"
description      "Installs/Configures newrelic"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.5.0"

depends          'apt'
depends          'build-essential'
depends          'python'
depends          'runit'

%w{ ubuntu debian }.each do |os|
  supports os
end

recipe "newrelic::default", "Installs NewRelic"
recipe "newrelic::do_setup_repository", "Adds NewRelic to APT list sources"
recipe "newrelic::install_newrelic_php5", "Installs NewRelic PHP Monitoring"
recipe "newrelic::install_newrelic_nrsysmond", "Installs NewRelic System Monitoring"
recipe "newrelic::install_newrelic_plugin_agent", "Installs the newrelic plugin agent"


attribute "newrelic/enabled",
  :display_name => "Enabled NewRelic",
  :description => "Whether or not NewRelic should be enabled",
  :choice => ["true", "false"],
  :default => "true",
  :recipes => [
    "newrelic::default",
    "newrelic::install_newrelic_php5",
    "newrelic::install_newrelic_nrsysmond"
  ]

attribute "newrelic/license_key",
  :display_name => "NewRelic License Key",
  :description => "NewRelic License Key to connect monitoring to your account",
  :required => "required",
  :recipes => [
    "newrelic::default",
    "newrelic::install_newrelic_php5",
    "newrelic::install_newrelic_nrsysmond"
  ]

attribute "newrelic/log_location",
  :display_name => "Log Location",
  :description => "Where should the NewRelic Log be located?",
  :default => "/var/log/newrelic/php_agent.log",
  :recipes => [
    "newrelic::default",
    "newrelic::install_newrelic_php5",
    "newrelic::install_newrelic_nrsysmond"
  ]

attribute "newrelic/log_level",
  :display_name => "NewRelic PHP Agent Log Level",
  :description => "The level of reporting set for the PHP Agent",
  :default => "info",
  :choice => ["always","error","warning","info","verbose","debug","verbosedebug"],
  :recipes => [
    "newrelic::default",
    "newrelic::install_newrelic_php5",
    "newrelic::install_newrelic_nrsysmond"
  ]

attribute "newrelic/app_name",
  :display_name => "App Name",
  :description => "Name of the PHP App in NewRelic",
  :default => "PHP Application",
  :required => "recommended",
  :recipes => [
    "newrelic::default",
    "newrelic::install_newrelic_php5",
    "newrelic::install_newrelic_nrsysmond"
  ]

attribute "newrelic/fqdn",
  :display_name => "Domain Name for APC Monitoring",
  :description => "Domain name for apc monitoring",
  :required => "required",
  :recipes => [
    "newrelic::install_newrelic_plugin_agent"
  ]


