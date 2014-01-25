# coding: utf-8
require 'spec_helper'

describe 'network::firewall' do
  context iptables do
    it 'drops INPUT packets' do
      expect(subject).to have_rule('INPUT DROP')
    end # it

    it 'drops FORWARD packets' do
      expect(subject).to have_rule('FORWARD DROP')
    end # it

    it 'accepts OUTPUT packets' do
      expect(subject).to have_rule('OUTPUT ACCEPT')
    end # it

    it "drops packets from TCP sessions that don't begin with SYN" do
      expect(subject).to have_rule('-p tcp -m tcp ! ' +
        '--tcp-flags FIN,SYN,RST,ACK SYN -m state --state NEW -j DROP')
    end # it

    it 'accepts icmp type 8 packets' do
      expect(subject).to have_rule('-p icmp -m icmp --icmp-type 8 -j ACCEPT')
    end # it

    it 'accepts icmp type 11 packets' do
      expect(subject).to have_rule('-p icmp -m icmp --icmp-type 11 -j ACCEPT')
    end # it

    it 'accepts packets on RELATED/ESTABLISHED connections' do
      expect(subject)
        .to have_rule('-m state --state RELATED,ESTABLISHED -j ACCEPT')
    end # it

    it 'accepts packets on port 22 (ssh)' do
      expect(subject).to have_rule('-p tcp -m state --state NEW ' +
        '-m tcp --dport 22 -j ACCEPT')
    end # it

    it 'rejects all other packets with icmp-host-prohibited message' do
      expect(subject)
        .to have_rule('-j REJECT --reject-with icmp-host-prohibited')
    end # it
  end # context
end # describe
