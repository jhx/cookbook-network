# coding: utf-8
require 'spec_helper'

describe 'network::network' do
  context file('/etc/sysconfig/network') do
    it 'is file' do
      expect(subject).to be_file
    end # it

    it 'is owned by root' do
      expect(subject).to be_owned_by('root')
    end # it

    it 'is in group root' do
      expect(subject).to be_grouped_into('root')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it

    it 'matches expected file header' do
      expect(subject.content).to match('# fake')
    end # it

    it 'matches expected NETWORKING' do
      expect(subject.content).to match('NETWORKING=yes')
    end # it

    it 'matches expected NETWORKING_IPV6' do
      expect(subject.content).to match('NETWORKING_IPV6=no')
    end # it
  end # context
end # describe
