# coding: utf-8
require 'spec_helper'

describe 'network::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.set['file']['header'] = 'node.file.header'
    end.converge(described_recipe)
  end # let

  describe 'network::hosts' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'network::network' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

end # describe
