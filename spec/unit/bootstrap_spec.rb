# encoding: utf-8
require 'spec_helper'

describe 'matrix_server::bootstrap' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      # required for sysctl cookbook
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  #----------------------------------------------------------------- package[]
  describe 'man' do
    it 'installs described package' do
      expect(chef_run).to install_package(subject)
    end # it
  end # describe

  describe 'nano' do
    it 'installs described package' do
      expect(chef_run).to install_package(subject)
    end # it
  end # describe

  describe 'wget' do
    it 'installs described package' do
      expect(chef_run).to install_package(subject)
    end # it
  end # describe

  describe 'which' do
    it 'installs described package' do
      expect(chef_run).to install_package(subject)
    end # it
  end # describe

end # describe
