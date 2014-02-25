# encoding: utf-8
require 'spec_helper'

describe 'network::dns_tools' do
  describe package('bind-utils'), :if => os?(:rhel) do
    it 'is installed' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe package('dnsutils'), :if => os?(:debian) do
    it 'is installed' do
      expect(subject).to be_installed
    end # it
  end # describe

end # describe
