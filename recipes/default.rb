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
include_recipe 'mysql::server'

include_recipe 'matrix_server::automysqlbackup'
include_recipe 'matrix_server::bash'
include_recipe 'matrix_server::network'
include_recipe 'matrix_server::ntp'
include_recipe 'matrix_server::passenger_ohai_plugin'
include_recipe 'matrix_server::passenger'
include_recipe 'matrix_server::passenger_nginx'
include_recipe 'matrix_server::r_project'
include_recipe 'matrix_server::rails_app_db'
include_recipe 'matrix_server::rails_app_web'
include_recipe 'matrix_server::sudo'
