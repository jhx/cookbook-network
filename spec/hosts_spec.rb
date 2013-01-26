require 'chefspec'
require 'fauxhai'

describe 'network::hosts' do
  before do
    Fauxhai.mock do |node|
      node['file'] = {
        'header' => 'node.file.header'
      }
    end # Fauxhai.mock
  end # before
  
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'network::hosts' }
  
  it 'should include recipe network::common' do
    chef_run.should include_recipe 'network::common'
  end # it 'should include recipe network::common'
  
  it 'should create /etc/hosts owned by root:wheel' do
    file = '/etc/hosts'
    chef_run.should create_file_with_content file, 'node.file.header'
    chef_run.template(file).should be_owned_by 'root', 'wheel'
  end # it 'should create /etc/hosts owned by root:wheel'
  
end # describe 'network::hosts'
