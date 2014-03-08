# encoding: utf-8
require 'spec_helper'

describe 'matrix_server::chef_client' do
  cached(:chef_run) do
    ChefSpec::Runner.new do |node|
      # required for sysctl cookbook
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  #------------------------------------------------------ directory[/etc/chef]
  describe '/etc/chef' do
    it 'creates directory with expected owner, group' do
      expect(chef_run).to create_directory(subject)
        .with(:owner => 'root', :group => 'root')
    end # it
  end # describe

  #--------------------------------- file[/etc/chef/encrypted_data_bag_secret]
  describe '/etc/chef/encrypted_data_bag_secret' do
    it 'creates file with expected owner, group, mode' do
      expect(chef_run).to create_file(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0600')
    end # it
  end # describe

  #------------------------------------------------ logrotate_app[chef_client]
  describe '/etc/logrotate.d/chef_client' do
    it 'creates template with expected owner, group, mode' do
      expect(chef_run).to create_template(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0644')
    end # it

    it 'renders file with expected path' do
      expect(chef_run).to render_file(subject)
        .with_content('/var/log/chef/client.log')
    end # it

    it 'renders file with expected frequency' do
      expect(chef_run).to render_file(subject)
        .with_content('weekly')
    end # it

    it 'renders file with expected rotate limit' do
      expect(chef_run).to render_file(subject)
        .with_content('rotate 12')
    end # it

    it 'renders file with expected options (missingok)' do
      expect(chef_run).to render_file(subject)
        .with_content('missingok')
    end # it

    it 'renders file with expected options (compress)' do
      expect(chef_run).to render_file(subject)
        .with_content('compress')
    end # it

    it 'renders file with expected options (delaycompress)' do
      expect(chef_run).to render_file(subject)
        .with_content('delaycompress')
    end # it

    it 'renders file with expected postrotate command' do
      expect(chef_run).to render_file(subject)
        .with_content('service chef-client reload')
    end # it
  end # describe

end # describe
