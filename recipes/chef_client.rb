# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Recipe:: chef_client
#
# Author:: Doc Walker (<doc.walker@jameshardie.com>)
#
# Copyright 2014, James Hardie Building Products, Inc.
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

#-------------------------------------------------------- directory[/etc/chef]
directory '/etc/chef' do
  owner 'root'
  group 'root'
end # directory

#----------------------------------- file[/etc/chef/encrypted_data_bag_secret]
file '/etc/chef/encrypted_data_bag_secret' do
  owner 'root'
  group 'root'
  mode  '0600'
end # file

#-------------------------------------------------- logrotate_app[chef_client]
logrotate_app 'chef_client' do
  cookbook      'logrotate'
  template_mode '0644'
  path          '/var/log/chef/client.log'
  frequency     'weekly'
  rotate        12
  options       %w(missingok compress delaycompress)
  postrotate    'service chef-client reload'
end # logrotate_app
