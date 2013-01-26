require 'chefspec'
require 'fauxhai'

describe 'network::network' do
  before do
    Fauxhai.mock do |node|
      node['file'] = {
        'header' => 'node.file.header'
      }
    end # Fauxhai.mock
  end # before
  
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'network::network' }
  
  it 'should include recipe network::common' do
    chef_run.should include_recipe 'network::common'
  end # it 'should include recipe network::common'
  
  it 'should create /etc/sysconfig/network owned by root:root' do
    file = '/etc/sysconfig/network'
    chef_run.should create_file_with_content file, 'node.file.header'
    chef_run.template(file).should be_owned_by 'root', 'root'
  end # it 'should create /etc/hosts owned by root:root'
  
end # describe 'network::network'
