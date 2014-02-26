# encoding: utf-8
require 'spec_helper'

describe 'network::dns_tools' do
  [
    { :platform => 'centos', :version => '5.9' },
    { :platform => 'centos', :version => '6.5' },
    { :platform => 'redhat', :version => '5.9' },
    { :platform => 'redhat', :version => '6.5' },
    { :platform => 'ubuntu', :version => '12.04' }
  ].each do |i|
    context "#{i[:platform]}/#{i[:version]}" do
      let(:chef_run) do
        ChefSpec::Runner.new(i) do |node|
          # override cookbook attributes
          node.set['file']['header'] = 'node.file.header'
        end.converge(described_recipe)
      end # let

      describe 'network::common' do
        it 'includes described recipe' do
          expect(chef_run).to include_recipe(subject)
        end # it
      end # describe

      describe 'dns' do
        it 'installs described package' do
          case chef_run.node['platform_family']
          when 'rhel'
            expect(chef_run).to install_package(subject)
              .with_package_name('bind-utils')
          when 'debian'
            expect(chef_run).to install_package(subject)
              .with_package_name('dnsutils')
          end # case
        end # it
      end # describe

    end # context
  end # [...].each

end # describe
