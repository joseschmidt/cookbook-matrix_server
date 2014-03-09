# encoding: utf-8
require 'spec_helper'

describe 'matrix_server::sudo' do
  cached(:chef_run) do
    ChefSpec::Runner.new do |node|
      # required for sysctl cookbook
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  #------------------------------------------------------ include_recipe[sudo]
  describe 'sudo' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  #-------------------------------------------------------------- sudo[jeeves]
  describe 'jeeves' do
    it 'installs described sudoer' do
      expect(chef_run).to install_sudoer(subject).with_nopasswd(true)
    end # it
  end # describe

end # describe
