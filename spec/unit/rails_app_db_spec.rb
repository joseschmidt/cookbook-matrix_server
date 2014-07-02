# encoding: utf-8
require 'spec_helper'

describe 'matrix_server::rails_app_db' do
  before do
    allow(Chef::Sugar::DataBag).to receive(:encrypted_data_bag_item).and_return(
      'insql' => 'insql_password',
      'matrix' => 'matrix_password',
      'matrix_staging' => 'matrix_staging_password',
      'mysql' => {
        'root' => 'root_password'
      },
      'mysqladmin' => 'mysqladmin_password',
      'stage1_db_username' => 'stage1_db_password',
      'stage2_db_username' => 'stage2_db_password',
      'wwuser' => 'wwuser_password'
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
      node.override['rails_app']['stages'] = [
        {
          'name'                    => 'stage1',
          'codename'                => 'st1',
          'db_port'                 => 'stage1_db_port',
          'db_database'             => 'stage1_db_database',
          'db_username'             => 'stage1_db_username',
          'db_encoding'             => 'stage1_db_utf8',
          'db_collation'            => 'stage1_db_utf8_general_ci',
          'db_host'                 => 'stage1_db_localhost'
        },
        {
          'name'                    => 'stage2',
          'codename'                => 'st2',
          'db_port'                 => 'stage2_db_port',
          'db_database'             => 'stage2_db_database',
          'db_username'             => 'stage2_db_username',
          'db_encoding'             => 'stage2_db_utf8',
          'db_collation'            => 'stage2_db_utf8_general_ci',
          'db_host'                 => 'stage2_db_localhost'
        }
      ]

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

  #----------------------------------------------------- mysql_database_user[]
  %w(localhost %).each do |domain|
    describe "mysqladmin@#{domain}" do
      it 'grants user access to mysql database with expected options' do
        expect(chef_run).to grant_mysql_database_user(subject)
          .with_username(subject.split('@')[0])
          .with_host(domain)
          .with_password("#{subject.split('@')[0]}_password")
          .with_with_option(['GRANT OPTION'])
      end # it
    end # describe

    describe "insql@#{domain}" do
      it 'grants user access to mysql database with expected options' do
        expect(chef_run).to grant_mysql_database_user(subject)
          .with_username(subject.split('@')[0])
          .with_host(domain)
          .with_password("#{subject.split('@')[0]}_password")
          .with_database_name('matrix_production')
          .with_privileges(%w(SELECT INSERT UPDATE))
      end # it
    end # describe
  end # %w(...).each

  #-------------------------------------- mysql_database/mysql_database_user[]
  %w(stage1 stage2).each do |prefix|
    describe prefix do
      it 'creates database' do
        expect(chef_run).to create_mysql_database("#{prefix}_db_database")
          .with_encoding("#{prefix}_db_utf8")
          .with_collation("#{prefix}_db_utf8_general_ci")
      end # it
    end # describe

    describe "#{prefix}_#{prefix}_db_username@#{prefix}_db_localhost" do
      it 'grants user access to mysql database with expected options' do
        expect(chef_run).to grant_mysql_database_user(subject)
          .with_username("#{prefix}_db_username")
          .with_host("#{prefix}_db_localhost")
          .with_password("#{prefix}_db_password")
          .with_database_name("#{prefix}_db_database")
      end # it
    end # describe
  end # %w(...).each

  #----------------------------------------------- mysql_database_user[wwuser]
  describe 'wwuser' do
    it 'grants user access to mysql database with expected options' do
      expect(chef_run).to grant_mysql_database_user(subject)
        .with_username(subject)
        .with_host('%')
        .with_password("#{subject}_password")
        .with_database_name('matrix_production')
        .with_privileges(%w(SELECT))
    end # it
  end # describe

  #------------------------------------------------------ mysql_database[test]
  describe 'test' do
    it 'drops database' do
      expect(chef_run).to drop_mysql_database(subject)
    end # it
  end # describe

end # describe
