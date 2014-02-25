# encoding: utf-8
#
# Cookbook Name:: network
# Recipe:: hosts
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

include_recipe 'network::common'

template '/etc/hosts' do |t|
  owner   'root'
  group   'root'
  mode    '0644'
  variables(
    :header => node['file']['header'].gsub('@filename', t.name)
      .gsub('@hostname', node['hostname']),
    :hosts => node['network']['hosts']
  )
  notifies  :restart, 'service[network]'
  action  :create
end # template
