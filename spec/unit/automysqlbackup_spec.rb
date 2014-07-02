# encoding: utf-8
require 'spec_helper'

describe 'matrix_server::automysqlbackup' do
  before do
    allow(Chef::Sugar::DataBag).to receive(:encrypted_data_bag_item).and_return(
      'automysqlbackup' => 'automysqlbackup_password',
      'mysql' => {
        'root' => 'root_password'
      }
    )
  end # before

  cached(:chef_run) do
    ChefSpec::Runner.new do |node|
      # create a new environment
      env = Chef::Environment.new
      env.name 'qa'

      # stub the node to return this environment
      node.stub(:chef_environment).and_return(env.name)

      # stub any calls to Environment.load to return this environment
      Chef::Environment.stub(:load).and_return(env)

      # override cookbook attributes
      node.override['automysqlbackup']['backup_dir'] = '/var/tmp/backup_dir'
      node.override['automysqlbackup']['conf_dir'] = '/var/tmp/conf_dir'
      node.override['automysqlbackup']['conf_file'] =
        'automysqlbackup_conf_file'

      # required for build-essential cookbook on travis-ci
      # required for sysctl cookbook
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  #---------------------------------------------------------- include_recipe[]
  describe 'mysql::ruby' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'chef-sugar' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  #------------------------- cookbook_file[/etc/cron.daily/automysqlbackup.sh]
  describe '/etc/cron.daily/automysqlbackup.sh' do
    it 'creates file with expected owner, group, mode' do
      expect(chef_run).to create_cookbook_file(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0755')
    end # it
  end # describe

  #------------------------------------------- directory[/etc/automysqlbackup]
  describe '/var/tmp/conf_dir' do
    it 'creates directory with expected owner, group, mode' do
      expect(chef_run).to create_directory(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0755')
    end # it
  end # describe

  #----------------------- template[/etc/automysqlbackup/automysqlbackup.conf]
  describe '/var/tmp/conf_dir/automysqlbackup_conf_file' do
    it 'creates template with expected owner, group, mode' do
      expect(chef_run).to create_template(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0600')
    end # it

    it 'renders file with expected USERNAME' do
      expect(chef_run).to render_file(subject)
        .with_content('USERNAME=automysqlbackup')
    end # it

    it 'renders file with expected PASSWORD' do
      expect(chef_run).to render_file(subject)
        .with_content('PASSWORD=automysqlbackup_password')
    end # it

    it 'renders file with expected BACKUPDIR' do
      expect(chef_run).to render_file(subject)
        .with_content('BACKUPDIR="/var/tmp/backup_dir"')
    end # it
  end # describe

  #------------------------------------------------- directory[/var/backup/db]
  describe '/var/tmp/backup_dir' do
    it 'creates directory with expected owner, group, mode' do
      expect(chef_run).to create_directory(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0700')
    end # it
  end # describe

  #-------------------------------------- mysql_database_user[automysqlbackup]
  describe 'automysqlbackup' do
    it 'grants user access to mysql database with expected options' do
      expect(chef_run).to grant_mysql_database_user(subject)
        .with_username(subject)
        .with_host('localhost')
        .with_password("#{subject}_password")
        .with_privileges(['SELECT', 'LOCK TABLES'])
    end # it
  end # describe

end # describe
