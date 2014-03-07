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

#----------------------------------------------- cookbook_file[/etc/gitconfig]
# install global git config
cookbook_file '/etc/gitconfig' do
  owner  'root'
  group  'root'
  mode   '0644'
end # cookbook_file

#------------------------------- remote_file[/etc/profile.d/git-completion.sh]
# install git completion script
remote_file '/etc/profile.d/git-completion.sh' do
  source 'https://raw.github.com/git/git/master/contrib/completion/' \
    'git-completion.bash'
  owner  'root'
  group  'root'
  mode   '0644'
end # remote_file

#----------------------------------- remote_file[/etc/profile.d/git-prompt.sh]
# install git prompt script
remote_file '/etc/profile.d/git-prompt.sh' do
  source 'https://raw.github.com/git/git/master/contrib/completion/' \
    'git-prompt.sh'
  owner  'root'
  group  'root'
  mode   '0644'
end # remote_file

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
