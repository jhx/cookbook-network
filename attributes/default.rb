# encoding: utf-8
#
# Cookbook Name:: network
# Attributes:: default
#

default['network']['hosts']['127.0.0.1'] =
  %w(localhost.localdomain localhost)
ipaddress = node['ipaddress']
default['network']['hosts'][ipaddress] = [node['fqdn'], node['hostname']]
default['network']['firewall'] = [22]
