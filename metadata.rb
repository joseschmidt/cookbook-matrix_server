# encoding: utf-8
name              'matrix_server'
maintainer        'James Hardie Building Products, Inc.'
maintainer_email  'doc.walker@jameshardie.com'
description       'Configures application server for The Matrix.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
license           'Apache 2.0'
version           '0.1.0'

#--------------------------------------------------------------------- recipes
recipe            'matrix_server',
                  'Master recipe used to configure server'

#------------------------------------------------------- cookbook dependencies
depends           'build-essential' #, '~> 1.4'
depends           'chef-sugar' , '~> 1.2.4'
depends           'cron' , '~> 1.2.2'
depends           'database' , '~> 1.3.10'
depends           'java' , '~> 1.29.0'
depends           'logrotate' , '~> 1.5.0'
depends           'mysql', '~> 2.1.0'
depends           'nodejs' , '~> 2.2.0'
depends           'ohai', '>= 1.1.4'
depends           'openssh', '~> 1.3.4'
depends           'rvm', '~> 0.9.2'
depends           'selinux', '~> 0.8.0'
depends           'ssh_known_hosts', '~> 2.0.0'
depends           'sudo', '~> 2.3.0'
depends           'sysctl', '~> 0.6.2'
depends           'user', '~> 0.3.0'
depends           'yum-epel', '~> 0.5.3'

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
