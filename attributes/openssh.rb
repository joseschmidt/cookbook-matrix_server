# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Attributes:: openssh
#

default['openssh']['server']['accept_env'] = [
  'LANG LANGUAGE LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY',
  'LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT',
  'LC_IDENTIFICATION LC_ALL'
]
default['openssh']['server']['client_alive_count_max']  = '1'
default['openssh']['server']['client_alive_interval']   = '60'
default['openssh']['server']['login_grace_time']        = '120'
default['openssh']['server']['max_startups']            = '10'
default['openssh']['server']['password_authentication'] = 'no'
default['openssh']['server']['permit_root_login']       = 'no'
default['openssh']['server']['protocol']                = '2'
default['openssh']['server']['subsystem']               =
  'sftp /usr/libexec/openssh/sftp-server'
default['openssh']['server']['syslog_facility']         = 'AUTHPRIV'
default['openssh']['server']['t_c_p_keep_alive']        = 'no'
default['openssh']['server']['use_d_n_s']               = 'no'
default['openssh']['server']['use_p_a_m']               = 'no'
default['openssh']['server']['x11_forwarding']          = 'yes'
