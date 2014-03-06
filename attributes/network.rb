# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Attributes:: network
#

default['network']['hosts']['127.0.0.1'] =
  %w(localhost.localdomain localhost)
default['network']['hosts'][node['ipaddress']] =
  [node['fqdn'], node['hostname']]
  # ["#{node['fqdn']}", "#{node['hostname']}"]
default['network']['firewall'] = [22]
