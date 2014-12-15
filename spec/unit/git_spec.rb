# encoding: utf-8
require 'spec_helper'

describe 'matrix_server::git' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      # required for sysctl cookbook
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  #--------------------------------------------- cookbook_file[/etc/gitconfig]
  describe '/etc/gitconfig' do
    it 'creates file with expected owner, group, mode' do
      expect(chef_run).to create_cookbook_file(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0644')
    end # it
  end # describe

  #----------------------------- remote_file[/etc/profile.d/git-completion.sh]
  describe '/etc/profile.d/git-completion.sh' do
    it 'creates file with expected owner, group, mode' do
      expect(chef_run).to create_remote_file(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0644')
    end # it
  end # describe

  #--------------------------------- remote_file[/etc/profile.d/git-prompt.sh]
  describe '/etc/profile.d/git-prompt.sh' do
    it 'creates file with expected owner, group, mode' do
      expect(chef_run).to create_remote_file(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0644')
    end # it
  end # describe

end # describe
