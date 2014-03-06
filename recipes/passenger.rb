# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Recipe:: passenger
#
# Author:: Doc Walker (<doc.walker@jameshardie.com>)
#
# Copyright 2013-2014, James Hardie Building Products, Inc.
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
include_recipe 'build-essential'
include_recipe 'yum-epel'         # required to install git with rvm recipe
include_recipe 'rvm'
include_recipe 'rvm::system'
include_recipe 'rvm::gem_package'

#------------------------------------------------------------------- package[]
%w(ruby-devel curl-devel).each do |pkg|
  package pkg
end # %w(...)

#------------------------------------- rvm_environment[ruby-1.9.3-p327@global]
rvm_environment node['passenger']['ruby_string']

#------------------------------------------------------------ rvm_global_gem[]
rvm_global_gem 'rake'
rvm_global_gem 'ohai'
rvm_global_gem 'passenger' do
  version node['passenger']['version']
  action :install
end # rvm_global_gem
