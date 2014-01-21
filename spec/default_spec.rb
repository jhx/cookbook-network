# coding: utf-8
require 'spec_helper'

describe 'network::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.set['file'] = {
        'header' => 'node.file.header'
      }
    end.converge(described_recipe)
  end # let

  it 'includes recipe network::hosts' do
    expect(chef_run).to include_recipe('network::hosts')
  end # it

  it 'includes recipe network::network' do
    expect(chef_run).to include_recipe('network::network')
  end # it

end # describe
