# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Attributes:: rvm
#

# rvm global default ruby
# refer to attributes/passenger.rb for specific ruby/gemset for passenger
default['rvm']['default_ruby']              = 'ruby-1.9.3-p327@global'

default['rvm']['gem_package']['rvm_string'] = node['rvm']['default_ruby']
default['rvm']['group_users']               = %w(jeeves)
