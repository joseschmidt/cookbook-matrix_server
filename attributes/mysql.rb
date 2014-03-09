# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Attributes:: mysql
#

normal['mysql']['bind_address:']          = '0.0.0.0'
normal['mysql']['old_passwords:']         = 0
normal['mysql']['tunable']['log_error']   = '/var/log/mysqld.log'
