# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Recipe:: bash
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

#------------------------------------- template[/etc/profile.d/jhx_profile.sh]
template '/etc/profile.d/jhx_profile.sh' do |t|
  owner   'root'
  group   'root'
  mode    '0644'
  variables(
    :header => node['file']['header'].gsub('@filename', t.name)
      .gsub('@hostname', node['hostname'])
  )
  action  :create
end # template

#----------------------------------------- cookbook_file[/usr/local/bin/rmate]
# install TextMate 2 remote mate
cookbook_file '/usr/local/bin/rmate' do
  owner   'root'
  group   'root'
  mode    '0755'
end # cookbook_file

#---------------------------------------------------------------------- file[]
%w(
  /etc/profile.d/path_opt_vagrant_ruby_bin.sh
  /etc/profile.d/path_sbin.sh
  /etc/profile.d/path_usr_sbin.sh).each do |f|
  file f do
    action :delete
  end # file
end # %w(...).each
