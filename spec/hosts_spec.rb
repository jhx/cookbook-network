# coding: utf-8
require 'spec_helper'

describe 'network::hosts' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.set['file']['header'] = 'node.file.header'
    end.converge(described_recipe)
  end # let

  it 'includes recipe network::common' do
    expect(chef_run).to include_recipe('network::common')
  end # it

  describe '/etc/hosts' do
    it 'creates template with expected owner, group' do
      expect(chef_run).to create_template(subject)
        .with(:owner => 'root', :group => 'root')
    end # it

    it 'renders file with expected header' do
      expect(chef_run).to render_file(subject)
        .with_content('node.file.header')
    end # it
  end # describe

end # describe
