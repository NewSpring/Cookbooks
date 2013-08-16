require 'chefspec'
require_relative '../../../spec/spec_helper'

describe 'perrynoble::default' do
  let (:chef_run) { 
     chef_run = ChefSpec::ChefRunner.new({:platform => 'ubuntu', :version => '10.04'}) 
     chef_run.converge 'perrynoble::default'
  }
 
  it 'should create the index file' do
    chef_run.should create_file_with_content '/var/www/perrynoble.com/index.php', 'http://perrynoble.com/admin.php'
  end

  it 'should create the admin file' do 
    chef_run.should create_file_with_content '/var/www/perrynoble.com/admin.php', 'http://perrynoble.com/admin.php'
  end

  it 'should create the images folder' do
    chef_run.should create_directory '/var/www/perrynoble.com/images/uploads/'
  end

  it 'should create the themes folder' do 
    chef_run.should create_link '/var/www/perrynoble.com/themes/'
  end

  it 'should create the .htaccess file' do
    chef_run.should create_cookbook_file "/var/www/perrynoble.com/.htaccess"
  end
 
  it 'should create the appropriate .conf files.' do
    chef_run.should create_file_with_content "/etc/apache2/sites-available/perrynoble.conf", "perrynoble.com"
  end
end





