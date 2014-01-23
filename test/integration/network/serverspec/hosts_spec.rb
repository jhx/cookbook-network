# coding: utf-8
require 'spec_helper'

describe 'network::hosts' do
  context file('/etc/hosts') do
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
  end # context
end # describe
