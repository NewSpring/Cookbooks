name             "datadog"
maintainer       "Datadog"
maintainer_email "package@datadoghq.com"
license          "Apache 2.0"
description      "Installs/Configures datadog components"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.1"

%w{
  amazon
  centos
  debian
  redhat
  scientific
  ubuntu
}.each do |os|
  supports os
end

depends          "apt"
depends          "chef_handler", "~> 1.1.0"
depends          "yum"

recipe "datadog::default", "Default"
recipe "datadog::dd-agent", "Installs the Datadog Agent"
recipe "datadog::dd-handler", "Installs a Chef handler for Datadog"
recipe "datadog::repository", "Installs the Datadog package repository"
recipe "datadog::dogstatsd-python", "Installs the Python dogstatsd package for custom metrics"
recipe "datadog::dogstatsd-ruby", "Installs the Ruby dogstatsd package for custom metrics"

# integration-specific
recipe "datadog::cassandra", "Installs and configures the Cassandra integration"
recipe "datadog::couchdb", "Installs and configures the CouchDB integration"
recipe "datadog::memcache", "Installs and configures the MemCache integration"
recipe "datadog::apache", "Installs and configures the Apache integration"
recipe "datadog::mysql", "Installs and configures the MySQL integration"

attribute "datadog/api_key",
  :display_name => "Datadog API Key",
  :description => "API Key for the Datadog Service",
  :required => "required",
  :recipes => [
    "datadog::default",
    "datadog::dd-agent",
    "datadog::dd-handler",
    "datadog::repository",
    "datadog::dogstatsd-python",
    "datadog::dogstatsd-ruby",
    "datadog::cassandra",
    "datadog::couchdb"
  ]

  attribute "datadog/use_ec2_instance_id",
    :display_name => "Use EC2 Instance ID",
    :description => "Use EC2 Instance ID as the host identifier rather than the hostname for the agent or the nodename for chef-handler",
    :choice => ["true", "false"],
    :default => "false",
    :recipes => [
      "datadog::default",
      "datadog::dd-agent",
      "datadog::dd-handler",
      "datadog::repository",
      "datadog::dogstatsd-python",
      "datadog::dogstatsd-ruby",
      "datadog::cassandra",
      "datadog::couchdb"
    ]

  attribute "datadog/tags",
    :display_name => "Tag Instance",
    :description => "Tag each server instance for metric tracking in datadog.",
    :required => "recommended",
    :recipes => [
      "datadog::default",
      "datadog::dd-agent",
      "datadog::dd-handler",
      "datadog::repository",
      "datadog::dogstatsd-python",
      "datadog::dogstatsd-ruby",
      "datadog::cassandra",
      "datadog::couchdb"
    ]

  attribute "datadog/apache/status_url",
    :display_name => "Apache Status URL",
    :description => "The apache status url that display apache status info.",
    :required => "recommended",
    :recipes => [ "datadog::apache" ]

  attribute "datadog/mysql/server",
    :display_name => "MySQl Server URL",
    :description => "The URL for MYSQL server information",
    :required => "recommended",
    :recipes => [ "datadog::mysql" ]

  attribute "datadog/mysql/user",
    :display_name => "MySQl Datadog User",
    :description => "The User for MYSQL server",
    :required => "recommended",
    :recipes => [ "datadog::mysql" ]

  attribute "datadog/mysql/pass",
    :display_name => "MySQl Server password",
    :description => "The password for MYSQL server information",
    :required => "recommended",
    :recipes => [ "datadog::mysql" ]

  attribute "datadog/memcache/url",
    :display_name => "Memcache Listen URL",
    :description => "Memcache Listen URL",
    :required => "recommended",
    :recipes => [ "datadog::memcache" ]

   attribute "datadog/memcache/port",
    :display_name => "Memcache Listen Port",
    :description => "Memcache Listen Port",
    :required => "recommended",
    :recipes => [ "datadog::memcache" ]




