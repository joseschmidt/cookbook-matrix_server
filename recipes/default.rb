# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Recipe:: default
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

#------------------------------------------------------------ include_recipe[]
# prerequisites (dependencies indicated by => notation)
include_recipe 'user::data_bag'
include_recipe 'selinux::permissive'
include_recipe 'mysql::server'
include_recipe 'matrix_server::passenger_ohai_plugin'
include_recipe 'matrix_server::passenger'           # => passenger_ohai_plugin
                                                           # => user::data_bag

# recipes (alphabetical order where possible)
include_recipe 'cron'
include_recipe 'java'
include_recipe 'matrix_server::automysqlbackup'             # => mysql::server
include_recipe 'matrix_server::bash'
include_recipe 'matrix_server::bootstrap'
include_recipe 'matrix_server::chef_client'
include_recipe 'matrix_server::git'
include_recipe 'matrix_server::network'
include_recipe 'matrix_server::ntp'
include_recipe 'matrix_server::passenger_nginx'                 # => passenger
include_recipe 'matrix_server::r_project'
include_recipe 'matrix_server::rails_app_db'                # => mysql::server
include_recipe 'matrix_server::rails_app_web'
include_recipe 'matrix_server::ssh_known_hosts'
include_recipe 'matrix_server::sudo'
include_recipe 'matrix_server::sysctl'
include_recipe 'nodejs'
include_recipe 'openssh'
