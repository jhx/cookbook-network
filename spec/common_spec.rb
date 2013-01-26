require 'chefspec'

describe 'network::common' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'network::common' }
  
  it 'should provide network resource (action: nothing)' do
    chef_run.should nothing_service 'network'
  end # it 'should provide network resource (action: nothing)'
  
end # describe 'network::common'
