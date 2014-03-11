# encoding: utf-8
require 'spec_helper'

describe 'matrix_server::bash' do
  cached(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.override['file']['header'] = 'node.file.header'

      # required for sysctl cookbook
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  #----------------------------------- template[/etc/profile.d/jhx_profile.sh]
  describe '/etc/profile.d/jhx_profile.sh' do
    it 'creates template with expected owner, group, mode' do
      expect(chef_run).to create_template(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0644')
    end # it

    it 'renders file with expected header' do
      expect(chef_run).to render_file(subject)
        .with_content('node.file.header')
    end # it
  end # describe

  #--------------------------------------- cookbook_file[/usr/local/bin/rmate]
  describe '/usr/local/bin/rmate' do
    it 'creates file with expected owner, group, mode' do
      expect(chef_run).to create_cookbook_file(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0755')
    end # it
  end # describe

  #------------------------- file[/etc/profile.d/path_opt_vagrant_ruby_bin.sh]
  describe '/etc/profile.d/path_opt_vagrant_ruby_bin.sh' do
    it 'deletes file' do
      expect(chef_run).to delete_file(subject)
    end # it
  end # describe

  #----------------------------------------- file[/etc/profile.d/path_sbin.sh]
  describe '/etc/profile.d/path_sbin.sh' do
    it 'deletes file' do
      expect(chef_run).to delete_file(subject)
    end # it
  end # describe

  #------------------------------------- file[/etc/profile.d/path_usr_sbin.sh]
  describe '/etc/profile.d/path_usr_sbin.sh' do
    it 'deletes file' do
      expect(chef_run).to delete_file(subject)
    end # it
  end # describe

end # describe
