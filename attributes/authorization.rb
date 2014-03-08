# encoding: utf-8
#
# Cookbook Name:: matrix_server
# Attributes:: authorization
#

node.set['authorization']['sudo']['groups'] = ['wheel']
node.set['authorization']['sudo']['include_sudoers_d'] = true
node.set['authorization']['sudo']['sudoers_defaults'] = [
  '!visiblepw',
  'env_reset',
  'env_keep = "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR \
               LS_COLORS MAIL PS1 PS2 QTDIR USERNAME \
               LANG LC_ADDRESS LC_CTYPE LC_COLLATE LC_IDENTIFICATION \
               LC_MEASUREMENT LC_MESSAGES LC_MONETARY LC_NAME LC_NUMERIC \
               LC_PAPER LC_TELEPHONE LC_TIME LC_ALL LANGUAGE LINGUAS \
               _XKB_CHARSET XAUTHORITY PATH SSH_AUTH_SOCK"'
]
