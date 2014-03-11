# encoding: utf-8
name              'matrix_server'
maintainer        'James Hardie Building Products, Inc.'
maintainer_email  'doc.walker@jameshardie.com'
description       'Installs and configures application server for ' \
                  'The Matrix.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
license           'Apache 2.0'
version           '0.1.0'

#--------------------------------------------------------------------- recipes
recipe            'matrix_server',
                  'Includes dependent recipes to install/configure server'

#------------------------------------------------------- cookbook dependencies
depends           'build-essential'
depends           'chef-sugar', '~> 1.1.0'
depends           'cron', '~> 1.2.2'
depends           'database', '~> 1.3.10'
depends           'java'
depends           'logrotate', '~> 1.5.0'
depends           'mysql', '~> 2.1.0'
depends           'nodejs'
depends           'ohai', '>= 1.1.4'
depends           'openssh'
depends           'rvm'
depends           'selinux'
depends           'simple_iptables'
depends           'sudo', '~> 2.3.0'
depends           'sysctl'
depends           'user'
depends           'yum-epel'

#--------------------------------------------------------- supported platforms
# tested
supports          'centos'

# platform_family?('rhel'): not tested, but should work
supports          'amazon'
supports          'oracle'
supports          'redhat'
supports          'scientific'

# platform_family?('debian'): not tested, but may work
supports          'debian'
supports          'ubuntu'
