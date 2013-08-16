require 'chefspec'
require 'spec_helper'

describe 'newspring::deploy' do
  let (:chef_run) { 
     chef_run = ChefSpec::ChefRunner.new({:platform => 'ubuntu', :version => '10.04'}) 
     chef_run.node.set['newspring'] = {
        "hostname" => "localhost",
        "username" => "newspring",
        "password" => "newspring",
        "database" => "expressionengine",
        "branch" => "master",
        "deploy_key" => "key"
     }
     chef_run.converge 'newspring::deploy'
  }

  it 'should create create assets/cache path' do
    chef_run.should create_directory "/var/www/newspring.cc/current/hello/expressionengine/cache"
  end

  it 'should create create expressionengine/cache path' do
    chef_run.should create_directory "/var/www/newspring.cc/current/hello/expressionengine/cache"
  end

  it 'should create tokens path for simple giving' do
    chef_run.should create_directory "/var/www/newspring.cc/current/hello/expressionengine/third_party/simple_giving/tokens"    
  end

  it 'should create the database.php file' do
    chef_run.should create_file "/var/www/newspring.cc/current/hello/expressionengine/config/database.php"
  end

  it 'should create the config.php file' do
    chef_run.should create_file "/var/www/newspring.cc/current/hello/expressionengine/config/config.php"
  end

  it 'should create the NewSpring configuration file.' do
    chef_run.should create_file_with_content "/etc/apache2/sites-available/newspring.conf", "newspring.cc"
  end
end
