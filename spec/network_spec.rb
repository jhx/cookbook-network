# coding: utf-8
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
    expect(chef_run).to include_recipe('network::common')
  end # it

  it 'should create /etc/sysconfig/network owned by root:root' do
    file = '/etc/sysconfig/network'
    expect(chef_run).to create_template(file)
      .with(:owner => 'root', :group => 'root')
    expect(chef_run).to render_file(file).with_content('node.file.header')
  end # it

end # describe
