# encoding: utf-8
require 'spec_helper'

describe 'network::common' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  describe 'network' do
    it 'does nothing' do
      service = chef_run.service(subject)
      expect(service).to do_nothing
    end # it
  end # describe

end # describe
