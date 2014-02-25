# encoding: utf-8
require 'spec_helper'

describe 'network::hosts' do
  describe file('/etc/hosts') do
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

    it 'includes expected file header' do
      expect(subject.content).to include('# fake')
    end # it
  end # describe
end # describe
