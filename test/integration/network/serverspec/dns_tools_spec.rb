# coding: utf-8
require 'spec_helper'

describe 'network::dns_tools' do
  os = backend(Serverspec::Commands::Base).check_os

  case os[:family]
  when 'RedHat'
    describe package('bind-utils') do
      it 'is installed' do
        expect(subject).to be_installed
      end # it
    end # describe
  when 'Debian'
    describe package('dnsutils') do
      it 'is installed' do
        expect(subject).to be_installed
      end # it
    end # describe
  end # case

end # describe
