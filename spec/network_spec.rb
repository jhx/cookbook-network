# coding: utf-8
require 'spec_helper'

describe 'network::network' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.set['file']['header'] = 'node.file.header'
    end.converge(described_recipe)
  end # let

  describe 'network::common' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe '/etc/sysconfig/network' do
    it 'creates template with expected owner, group, mode' do
      expect(chef_run).to create_template(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0644')
    end # it

    it 'renders file with expected header' do
      expect(chef_run).to render_file(subject)
        .with_content('node.file.header')
    end # it

    it 'notifies resource with expected action' do
      resource = chef_run.template(subject)
      expect(resource).to notify('service[network]').to(:restart).delayed
    end # it
  end # describe

end # describe
