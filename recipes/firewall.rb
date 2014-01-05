# coding: utf-8
#
# Cookbook Name:: network
# Recipe:: firewall
#
# Author:: Doc Walker (<doc.walker@jameshardie.com>)
#
# Copyright 2012-2013, James Hardie Building Products, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'simple_iptables'

simple_iptables_policy 'INPUT' do
  policy 'DROP'
end # simple_iptables_policy

simple_iptables_policy 'FORWARD' do
  policy 'DROP'
end # simple_iptables_policy

simple_iptables_policy 'OUTPUT' do
  policy 'ACCEPT'
end # simple_iptables_policy

# accept all traffic to localhost (127.0.0.1) interface
simple_iptables_rule 'RH-Firewall-1-INPUT' do
  rule '-i lo'
  jump 'ACCEPT'
end # simple_iptables_rule

# all TCP sessions should begin with SYN
simple_iptables_rule 'RH-Firewall-1-INPUT' do
  rule '-p tcp ! --syn -m state --state NEW'
  jump 'DROP'
end # simple_iptables_rule

# accept inbound ICMP packets
simple_iptables_rule 'RH-Firewall-1-INPUT' do
  rule [
    '-p icmp --icmp-type 8',
    '-p icmp --icmp-type 11'
  ]
  jump 'ACCEPT'
end # simple_iptables_rule

# allow established/related connections to continue
simple_iptables_rule 'RH-Firewall-1-INPUT' do
  rule '-m state --state ESTABLISHED,RELATED'
  jump 'ACCEPT'
end # simple_iptables_rule

node['network']['firewall'].each do |port|
  simple_iptables_rule 'RH-Firewall-1-INPUT' do
    rule "-m state --state NEW -m tcp -p tcp --dport #{port}"
    jump 'ACCEPT'
  end # simple_iptables_rule
end # .each

# reject all other inbound packets with icmp-host-prohibited message
simple_iptables_rule 'RH-Firewall-1-INPUT' do
  rule ''
  jump 'REJECT --reject-with icmp-host-prohibited'
end # simple_iptables_rule
