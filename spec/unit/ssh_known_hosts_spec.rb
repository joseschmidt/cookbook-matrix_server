# encoding: utf-8
require 'spec_helper'

describe 'matrix_server::ssh_known_hosts' do
  cached(:chef_run) do
    ChefSpec::Runner.new do |node|
      # required for sysctl cookbook
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  #------------------------------------------- include_recipe[ssh_known_hosts]
  describe 'ssh_known_hosts' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

end # describe
