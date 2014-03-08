# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Attributes:: sysctl
#

default['sysctl']['params'] = {
  'kernel.pid_max' => 999_999
}
