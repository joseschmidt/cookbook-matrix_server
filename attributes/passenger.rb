# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Attributes:: passenger
#

# passenger ruby/gemset (rvm will install and use the following)
# refer to attributes/rvm.rb for rvm global default ruby
normal['passenger']['ruby_string']              = 'ruby-1.9.3-rc1@global'

normal['passenger']['version']                  = '3.0.19'
normal['passenger']['version_map']              = {
  '3.0.19' => '1.2.6',
  '3.0.18' => '1.2.4',
  '3.9.1.beta' => '1.2.4', # problems building this
  '3.0.17' => '1.2.3',
  '3.0.15' => '1.2.2',
  '3.0.14' => '1.2.2',
  '3.0.13' => '1.2.1',
  '3.0.12' => '1.0.15',
  '3.0.11' => '1.0.10'
} # map versions: passenger => nginx

normal['passenger']['nginx']['prefix']          = '/opt/nginx-blah'
normal['passenger']['nginx']['user']            = 'nginx'

normal['passenger']['nginx']['conf_path']       =
  "#{node['passenger']['nginx']['prefix']}/conf/nginx.conf"

normal['passenger']['nginx']['configure_flags'] = [
  'auto',
  'auto-download',
  "prefix=#{node['passenger']['nginx']['prefix']}"
]
normal['passenger']['nginx']['modules']         = [
  'http_gzip_static_module' # not needed with passenger-3.0.19
]
