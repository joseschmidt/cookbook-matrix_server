# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Attributes:: r_project
#

default['r_project']['r']['version'] =
case node['platform_family']
when 'rhel'
  if node['platform_version'].to_f < 6.0
    '2.15.2-1.el5'
  else
    '3.0.2-1.el6'
  end # if
end # case

default['r_project']['qcc']['version'] = '2.3'
