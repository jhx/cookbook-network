# encoding: utf-8
require 'spec_helper'

describe 'network::firewall' do
  %w(debian rhel).each do |platform_family|
    context "platform family: #{platform_family}" do
      let(:chef_run) do
        ChefSpec::Runner.new do |node|
          # override cookbook attributes
          node.set['network']['firewall'] = [2, 178]
          node.set['platform_family'] = platform_family
        end.converge(described_recipe)
      end # let

      describe 'simple_iptables' do
        it 'includes described recipe' do
          expect(chef_run).to include_recipe(subject)
        end # it
      end # describe

      describe 'INPUT' do
        it 'sets expected chain policy' do
          expect(chef_run).to set_iptables_chain(subject)
            .with_policy('DROP')
        end # it
      end # describe

      describe 'FORWARD' do
        it 'sets expected chain policy' do
          expect(chef_run).to set_iptables_chain(subject)
            .with_policy('DROP')
        end # it
      end # describe

      describe 'OUTPUT' do
        it 'sets expected chain policy' do
          expect(chef_run).to set_iptables_chain(subject)
            .with_policy('ACCEPT')
        end # it
      end # describe

      describe 'accept_localhost' do
        it 'appends expected rule' do
          expect(chef_run).to append_iptables_rule(subject)
            .with_chain('RH-Firewall-1-INPUT')
            .with_rule('-i lo')
            .with_jump('ACCEPT')
        end # it
      end # describe

      describe 'drop_unless_begins_with_syn' do
        it 'appends expected rule' do
          expect(chef_run).to append_iptables_rule(subject)
            .with_chain('RH-Firewall-1-INPUT')
            .with_rule('-p tcp ! --syn -m state --state NEW')
            .with_jump('DROP')
        end # it
      end # describe

      describe 'accept_icmp' do
        it 'appends expected rule' do
          expect(chef_run).to append_iptables_rule(subject)
            .with_chain('RH-Firewall-1-INPUT')
            .with_rule(['-p icmp --icmp-type 8', '-p icmp --icmp-type 11'])
            .with_jump('ACCEPT')
        end # it
      end # describe

      describe 'accept_established_related' do
        it 'appends expected rule' do
          expect(chef_run).to append_iptables_rule(subject)
            .with_chain('RH-Firewall-1-INPUT')
            .with_rule('-m state --state ESTABLISHED,RELATED')
            .with_jump('ACCEPT')
        end # it
      end # describe

      [2, 178].each do |port|
        describe "accept_port_#{port}" do
          it 'appends expected rule' do
            expect(chef_run).to append_iptables_rule(subject)
              .with_chain('RH-Firewall-1-INPUT')
              .with_rule("-m state --state NEW -m tcp -p tcp --dport #{port}")
              .with_jump('ACCEPT')
          end # it
        end # describe
      end # [...]

      describe 'reject_other_inbound' do
        it 'appends expected rule' do
          expect(chef_run).to append_iptables_rule(subject)
            .with_chain('RH-Firewall-1-INPUT')
            .with_rule('')
            .with_jump('REJECT --reject-with icmp-host-prohibited')
        end # it
      end # describe

    end # context
  end # %w(...)

end # describe
