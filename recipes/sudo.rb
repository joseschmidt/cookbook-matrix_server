# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Recipe:: sudo
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

#-------------------------------------------------------- include_recipe[sudo]
include_recipe 'sudo'

#---------------------------------------------------------------- sudo[jeeves]
sudo 'jeeves' do
  user      'jeeves'
  nopasswd  true
end # sudo
