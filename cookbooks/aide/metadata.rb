name                "aide"
description         "Installs and configures AIDE HIDS"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
maintainer          "Elliot Kendall"
maintainer_email    "elliot.kendall@ucsf.edu"
license             "BSD"
version             "0.1.2"

recipe              "aide::default", "Installs and configures AIDE HIDS"

attribute "aide/cron_service",
  :display_name => "CRON Server",
  :description => "Which CRON server is being using on the server",
  :choice => ["cron","crond"],
  :default => "cron",
  :recipes => [
    "aide::default"
  ]

attribute "aide/report_url",
  :display_name => "Log or Email Address",
  :description => "Log or Email Address you can send the reports too",
  :required => "recommended",
  :recipes => [
    "aide::default"
  ]

attribute "aide/testmode",
  :display_name => "Test Mode",
  :description => "Place AIDE in Test Mode",
  :choice => ["true", "false"],
  :default => "false",
  :recipes => [
    "aide::default"
  ]

attribute "aide/binary",
  :display_name => "AIDE Binary",
  :description => "Where the AIDE Binary lives",
  :choice => ["/usr/bin/aide", "/usr/sbin/aide"],
  :default => "/usr/bin/aide",
  :recipes => [
    "aide::default"
  ]

attribute "aide/config",
  :display_name => "AIDE Config Location",
  :description => "Where the AIDE Config Location lives on the server",
  :choice => ["/etc/aide.conf", "/etc/aide/aide.conf"],
  :default => "/etc/aide/aide.conf",
  :recipes => [
    "aide::default"
  ]

attribute "aide/extra_parameters",
  :display_name => "Any Extra Parameters",
  :description => "Run the AIDE command with extra parameters. Only Used with Ubuntu/Debian",
  :default => "-c /etc/aide/aide.conf",
  :recipes => [
    "aide::default"
  ]
