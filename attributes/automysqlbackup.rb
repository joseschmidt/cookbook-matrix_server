# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Attributes:: automysqlbackup
#

# configuration file settings
# TODO: review backup script to see if these are hard-coded
# TODO: remove attribtues, if so
normal['automysqlbackup']['conf_dir']   = '/etc/automysqlbackup'
normal['automysqlbackup']['conf_file']  = 'automysqlbackup.conf'
normal['automysqlbackup']['backup_dir'] = '/var/backup/db'

# mysqlbackup user
normal['automysqlbackup']['user']       = 'automysqlbackup'
