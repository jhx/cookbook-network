require 'chefspec'
require 'fauxhai'

describe 'network::default' do
  before do
    Fauxhai.mock do |node|
      node['file'] = {
        'header' => 'node.file.header'
      }
    end # Fauxhai.mock
  end # before
  
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'network::default' }
  
  it 'should include recipe network::hosts' do
    chef_run.should include_recipe 'network::hosts'
  end # it 'should include recipe network::hosts'
  
  it 'should include recipe network::network' do
    chef_run.should include_recipe 'network::network'
  end # it 'should include recipe network::network'
  
end # describe 'network::default'
