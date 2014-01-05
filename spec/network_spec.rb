require 'spec_helper'

describe 'network::network' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.set['file'] = {
        'header' => 'node.file.header'
      }
    end.converge(described_recipe)
  end # let

  it 'should include recipe network::common' do
    chef_run.should include_recipe 'network::common'
  end # it 'should include recipe network::common'

  it 'should create /etc/sysconfig/network owned by root:root' do
    file = '/etc/sysconfig/network'
    expect(chef_run).to render_file(file).with_content('node.file.header')
    expect(chef_run.template(file).owner).to eq('root')
    expect(chef_run.template(file).group).to eq('root')
  end # it 'should create /etc/hosts owned by root:root'

end # describe 'network::network'
