# coding: utf-8
require 'spec_helper'

# TODO: make this platform_family-specific
describe 'network::dns_tools' do
  # rhel
  context package('bind-utils') do
    it 'is installed' do
      expect(subject).to be_installed
    end # it
  end # context

  # # debian
  # context package('dnsutils') do
  #   it 'is installed' do
  #     expect(subject).to be_installed
  #   end # it
  # end # context
end # describe
