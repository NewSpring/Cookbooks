name 'newrelic'
maintainer 'Escape Studios'
maintainer_email 'dev@escapestudios.com'
license 'MIT'
description 'Installs/Configures New Relic'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.3'

%w( debian ubuntu redhat centos fedora scientific amazon windows smartos ).each do |os|
  supports os
end

depends 'python'

recommends 'php'
recommends 'ms_dotnet4'
recommends 'curl'
recommends 'nodejs'

recipe 'newrelic::default', 'Adds the New Relic repository, installs & configures the New Relic server monitor agent.'
recipe 'newrelic::repository', 'Adds the New Relic repository.'
recipe 'newrelic::server-monitor-agent', 'Installs & configures the New Relic server monitor agent.'
recipe 'newrelic::dotnet-agent', 'Installs New Relic .NET agent.'
recipe 'newrelic::java-agent', 'Installs the New Relic Java agent.'
recipe 'newrelic::nodejs-agent', 'Installs New Relic Node.js agent.'
recipe 'newrelic::php-agent', 'Installs the New Relic PHP agent.'
recipe 'newrelic::python-agent', 'Installs the New Relic Python agent.'
recipe 'newrelic::ruby-agent', 'Installs the New Relic Ruby agent.'
recipe 'newrelic::meetme-plugin', 'Installs the New Relic MeetMe plugin.'

attribute "newrelic/license",
  :display_name => "NewRelic License Key",
  :description => "NewRelic License Key to connect monitoring to your account",
  :required => "required",
  :recipes => [
    "newrelic::default",
    "newrelic::dotnet-agent",
    "newrelic::java-agent",
    "newrelic::meetme-agent",
    "newrelic::nodejs-agent",
    "newrelic::php-agent",
    "newrelic::python-agent",
    "newrelic::ruby-agent",
    "newrelic::server-monitor-agent"
  ]

attribute "newrelic/application_monitoring/enabled",
  :display_name => "Enabled NewRelic App Monitoring",
  :description => "Whether or not NewRelic should be enabled",
  :choice => ["true", "false"],
  :default => "true",
  :recipes => [
    "newrelic::default",
    "newrelic::dotnet-agent",
    "newrelic::java-agent",
    "newrelic::meetme-agent",
    "newrelic::nodejs-agent",
    "newrelic::php-agent",
    "newrelic::python-agent",
    "newrelic::ruby-agent",
    "newrelic::server-monitor-agent"
  ]

attribute "newrelic/meetme-plugin/services",
  :display_name => "MeetMe Plugin Settings",
  :description => "Hash of settings passed to the meet me configuration",
  :required => "required",
  :recipes => [
    "newrelic::meetme-plugin"
  ]
