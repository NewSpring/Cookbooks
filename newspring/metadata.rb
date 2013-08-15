maintainer       "NewSpring Church"
maintainer_email "web@newspring.cc"
license          "All rights reserved"
description      "Installs/Configures newspring.cc"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.7"
depends "apache2"
depends "application"
depends "application_php"

attribute "newspring/deploy_key",
  :display_name => "Github SSH key for Deployment",
  :description => "The key this cookbook should use for authenication with Github",
  :required => "required",
  :recipes => [
    "newspring::default",
    "newspring::update"
  ]

attribute "newspring/branch",
  :display_name => "Git branch",
  :description => "Git branch or commit SHA used to specify which version of the site should be used",
  :required => "required",
  :recipes => [
    "newspring::default",
    "newspring::update"
  ]
