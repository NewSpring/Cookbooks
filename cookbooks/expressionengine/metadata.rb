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
  :type => "array"
  :recipes => [
    "expressionengine::multisite"
  ]
