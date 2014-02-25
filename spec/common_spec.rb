# encoding: utf-8
require 'spec_helper'

describe 'network::common' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  describe 'network' do
    it 'does not disable service' do
      expect(chef_run).to_not disable_service(subject)
    end # it

    it 'does not enable service' do
      expect(chef_run).to_not enable_service(subject)
    end # it

    it 'does not reload service' do
      expect(chef_run).to_not reload_service(subject)
    end # it

    it 'does not restart service' do
      expect(chef_run).to_not restart_service(subject)
    end # it

    it 'does not start service' do
      expect(chef_run).to_not start_service(subject)
    end # it

    it 'does not stop service' do
      expect(chef_run).to_not stop_service(subject)
    end # it
  end # describe

end # describe
