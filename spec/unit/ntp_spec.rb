# encoding: utf-8
require 'spec_helper'

describe 'matrix_server::ntp' do
  cached(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.override['file']['header'] = 'node.file.header'
      node.override['ntp']['server'] = 'time.nist.gov'

      # required for sysctl cookbook
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  #-------------------------------------------------------------- package[ntp]
  describe 'ntp' do
    it 'installs described package' do
      expect(chef_run).to install_package(subject)
    end # it
  end # describe

  #------------------------------------------------------------- service[ntpd]
  describe 'ntpd' do
    it 'stops described service' do
      expect(chef_run).to stop_service(subject)
    end # it

    it 'disables described service' do
      expect(chef_run).to disable_service(subject)
    end # it
  end # describe

  #---------------------------------------- template[/etc/cron.hourly/ntpdate]
  describe '/etc/cron.hourly/ntpdate' do
    it 'creates template with expected owner, group, mode' do
      expect(chef_run).to create_template(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0755')
    end # it

    it 'renders file with expected header' do
      expect(chef_run).to render_file(subject)
        .with_content('node.file.header')
    end # it
  end # describe

end # describe
