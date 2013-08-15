require 'chefspec'

describe 'unleash::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'unleash::default' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
