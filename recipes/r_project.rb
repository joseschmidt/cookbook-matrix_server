# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Recipe:: r_project
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
include_recipe 'yum-epel' if platform_family?('rhel')

#------------------------------------------------------------------ package[R]
Chef::Config['yum_timeout'] = 1800
# install R via epel
package 'R' do
  version node['r_project']['r']['version']
end # package

#------------------------------- cookbook_file[/var/chef/cache/qcc_2.3.tar.gz]
# current release:
#   http://cran.r-project.org/src/contrib/qcc_2.3.tar.gz
# archived releases:
#   http://cran.r-project.org/src/contrib/Archive/qcc

# set qcc filename
qcc_tar_gz = "qcc_#{node['r_project']['qcc']['version']}.tar.gz"
qcc_filename = "#{Chef::Config['file_cache_path']}/#{qcc_tar_gz}"

# upload qcc library
cookbook_file qcc_filename do
  owner     'root'
  group     'root'
  mode      '0644'
end # cookbook_file

#--------------------------------------------------- bash[install_qcc_library]
# install qcc library unless already installed
cmd = Mixlib::ShellOut.new("R --vanilla --quiet -e 'library(qcc)' 2>&1")
bash 'install_qcc_library' do
  cwd     ::File.dirname(qcc_filename)
  code    "sudo -E sh -c 'R CMD INSTALL #{qcc_filename}'"
  not_if    do
    cmd.run_command.stdout.include?(
      "Package 'qcc', version #{node['r_project']['qcc']['version']}"
    )
  end # not_if
end # bash

#------------------------------------------------- bash[uninstall_qcc_library]
# uninstall qcc library (not currently used)
bash 'uninstall_qcc_library' do
  code    "sudo -E sh -c 'R CMD REMOVE qcc'"
  action  :nothing
end # bash
