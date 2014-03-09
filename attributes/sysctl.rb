# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Attributes:: sysctl
#

normal['sysctl']['params'] = {
  'kernel.pid_max' => 999_999
}
