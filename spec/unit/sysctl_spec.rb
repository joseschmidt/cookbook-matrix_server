# encoding: utf-8
require 'spec_helper'

describe 'matrix_server::sysctl' do
  cached(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.override['sysctl']['params'] = {
        'kernel.pid_max' => 123_456
      }

      # required for sysctl cookbook
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  #---------------------------------------------------- include_recipe[sysctl]
  describe 'sysctl' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  #------------------------------------------------------------ sysctl_param[]
  describe 'kernel.pid_max' do
    it 'applies sysctl parameter with expected value' do
      expect(chef_run).to apply_sysctl_param(subject)
        .with_value(123_456)
    end # it
  end # describe

end # describe
