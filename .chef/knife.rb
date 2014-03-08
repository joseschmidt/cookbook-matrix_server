# encoding: utf-8

# settings for `knife cookbook test`
cookbook_path '.'
cache_type 'BasicFile'
cache_options(:path => "#{ENV['HOME']}/.chef/checksums")
