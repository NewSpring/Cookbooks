maintainer       "NewSpring Church"
maintainer_email "web@newspring.cc"
license          "All rights reserved"
description      "Installs/Configures Expression Engine Sites"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.7"

depends "apache2"

recipe "expressionengine::default", "Installs the Expressione Engine System and Clones down the repo"
recipe "expressionengine::multisite", "Installs and Configures EE MSM Sites"
recipe "expressionengine::update", "Deploys the Revision Specified"

attribute "ee/main",
  :display_name => "Main System Domain",
  :description => "The main domain that should setup EE, format like domain.com",
  :required => "required",
  :recipes => [
    "expressionengine::default",
    "expressionengine::multisite",
    "expressionengine::update"
  ]

attribute "ee/multisite",
  :display_name => "FQDN for Each Multisite Domain",
  :description => "FQDN for Each Multisite Domain, Format should look like http://domain.com or https://sub.domain.com",
  :required => "optional",
  :type => "array",
  :recipes => [
    "expressionengine::multisite"
  ]

attribute "ee/system_folder",
  :display_name => "EE System Folder",
  :description => "EE System Folder, by default its set to 'system'",
  :default => "system",
  :recipes => [
    "expressionengine::default"
  ]

attribute "ee/hostname",
  :display_name => "Database Hostname",
  :description => "Database hostname",
  :required => "required",
  :recipes => [
    "expressionengine::default"
  ]

attribute "ee/username",
  :display_name => "Database Username",
  :description => "Database Username",
  :required => "required",
  :recipes => [
    "expressionengine::default"
  ]

attribute "ee/password",
  :display_name => "Database Password",
  :description => "Database Password",
  :required => "required",
  :recipes => [
    "expressionengine::default"
  ]

attribute "ee/database",
  :display_name => "Database",
  :description => "Database",
  :required => "required",
  :recipes => [
    "expressionengine::default"
  ]