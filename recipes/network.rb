# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Recipe:: network
#
# Author:: Doc Walker (<doc.walker@jameshardie.com>)
#
# Copyright 2012-2014, James Hardie Building Products, Inc.
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

#---------------------------------------------------------------- package[dns]
package 'dns' do
  case node['platform_family']
  when 'rhel'
    package_name 'bind-utils'
  when 'debian'
    package_name 'dnsutils'
  end # case
  action :install
end # package

#------------------------------------------------------------ service[network]
service 'network' do
  action :nothing
end # service

#-------------------------------------------------------- template[/etc/hosts]
template '/etc/hosts' do |t|
  owner     'root'
  group     'root'
  mode      '0644'
  variables(
    :header => node['file']['header'].gsub('@filename', t.name)
      .gsub('@hostname', node['hostname']),
    :hosts => node['network']['hosts']
  )
  notifies  :restart, 'service[network]'
  action    :create
end # template

#-------------------------------------------- template[/etc/sysconfig/network]
template '/etc/sysconfig/network' do |t|
  owner     'root'
  group     'root'
  mode      '0644'
  variables(
    :header => node['file']['header'].gsub('@filename', t.name)
      .gsub('@hostname', node['hostname'])
  )
  notifies  :restart, 'service[network]'
  action    :create
end # template

#------------------------------------------------------------ include_recipe[]
include_recipe 'simple_iptables'

#---------------------------------------------------- simple_iptables_policy[]
simple_iptables_policy 'INPUT' do
  policy 'DROP'
end # simple_iptables_policy

simple_iptables_policy 'FORWARD' do
  policy 'DROP'
end # simple_iptables_policy

simple_iptables_policy 'OUTPUT' do
  policy 'ACCEPT'
end # simple_iptables_policy

#------------------------------------------------------ simple_iptables_rule[]
# accept all traffic to localhost (127.0.0.1) interface
simple_iptables_rule 'accept_localhost' do
  chain 'RH-Firewall-1-INPUT'
  rule  '-i lo'
  jump  'ACCEPT'
end # simple_iptables_rule

# all TCP sessions should begin with SYN
simple_iptables_rule 'drop_unless_begins_with_syn' do
  chain 'RH-Firewall-1-INPUT'
  rule  '-p tcp ! --syn -m state --state NEW'
  jump  'DROP'
end # simple_iptables_rule

# accept inbound ICMP packets
simple_iptables_rule 'accept_icmp' do
  chain 'RH-Firewall-1-INPUT'
  rule  [
      '-p icmp --icmp-type 8',
      '-p icmp --icmp-type 11'
    ]
  jump  'ACCEPT'
end # simple_iptables_rule

# allow established/related connections to continue
simple_iptables_rule 'accept_established_related' do
  chain 'RH-Firewall-1-INPUT'
  rule  '-m state --state ESTABLISHED,RELATED'
  jump  'ACCEPT'
end # simple_iptables_rule

node['network']['firewall'].each do |port|
  simple_iptables_rule "accept_port_#{port}" do
    chain 'RH-Firewall-1-INPUT'
    rule  "-m state --state NEW -m tcp -p tcp --dport #{port}"
    jump  'ACCEPT'
  end # simple_iptables_rule
end # .each

# reject all other inbound packets with icmp-host-prohibited message
simple_iptables_rule 'reject_other_inbound' do
  chain 'RH-Firewall-1-INPUT'
  rule  ''
  jump  'REJECT --reject-with icmp-host-prohibited'
end # simple_iptables_rule
