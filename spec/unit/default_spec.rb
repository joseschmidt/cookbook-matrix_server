# encoding: utf-8
require 'spec_helper'
require 'chef/application'

describe 'matrix_server' do
  before do
    Chef::Sugar::DataBag.stub(:encrypted_data_bag_item).and_return(
      'automysqlbackup' => 'automysqlbackup_password',
      'mysql' => {
        'root' => 'root_password'
      }
    )
  end # before

  cached(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.set['mysql']['server_debian_password'] = 'server_debian_password'
      node.set['mysql']['server_repl_password'] = 'server_repl_password'
      node.set['mysql']['server_root_password'] = 'server_root_password'
      node.set['passenger']['ruby_string'] = '1.9.3-fake'

      # required because default value is nil
      node.set['rvm']['install_pkgs'] = []

      # required for build-essential cookbook on travis-ci
      # required for simple_iptables cookbook
      # required for sysctl cookbook
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  #---------------------------------------------------------- include_recipe[]
  describe 'selinux::permissive' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'mysql::server' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::passenger_ohai_plugin' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::passenger' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'cron' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::automysqlbackup' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::bash' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::bootstrap' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::chef_client' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::network' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::ntp' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::passenger_nginx' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::r_project' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::rails_app_db' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::rails_app_web' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::sudo' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'matrix_server::sysctl' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'openssh' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'user::data_bag' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

end # describe
