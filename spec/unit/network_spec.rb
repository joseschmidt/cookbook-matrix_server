# encoding: utf-8
require 'spec_helper'

describe 'matrix_server::network' do
  [
    { :platform => 'centos', :version => '5.9' },
    { :platform => 'centos', :version => '6.5' },
    { :platform => 'redhat', :version => '5.9' },
    { :platform => 'redhat', :version => '6.5' },
    { :platform => 'ubuntu', :version => '12.04' }
  ].each do |i|
    context "#{i[:platform]}/#{i[:version]}" do
      cached(:chef_run) do
        ChefSpec::Runner.new(i) do |node|
          # override cookbook attributes
          node.set['file']['header'] = 'node.file.header'
          node.set['network']['firewall'] = [2, 178]

          # required for sysctl cookbook
          node.set['platform_family'] = 'rhel'
        end.converge(described_recipe)
      end # let

      #---------------------------------------------------------- package[dns]
      describe 'dns' do
        it 'installs described package' do
          case chef_run.node['platform_family']
          when 'rhel'
            expect(chef_run).to install_package(subject)
              .with_package_name('bind-utils')
          when 'debian'
            expect(chef_run).to install_package(subject)
              .with_package_name('dnsutils')
          end # case
        end # it
      end # describe

      #------------------------------------------------------ service[network]
      describe 'network' do
        it 'does not disable service' do
          expect(chef_run).to_not disable_service(subject)
        end # it

        it 'does not enable service' do
          expect(chef_run).to_not enable_service(subject)
        end # it

        it 'does not reload service' do
          expect(chef_run).to_not reload_service(subject)
        end # it

        it 'does not restart service' do
          expect(chef_run).to_not restart_service(subject)
        end # it

        it 'does not start service' do
          expect(chef_run).to_not start_service(subject)
        end # it

        it 'does not stop service' do
          expect(chef_run).to_not stop_service(subject)
        end # it
      end # describe

      #-------------------------------------------------- template[/etc/hosts]
      describe '/etc/hosts' do
        it 'creates template with expected owner, group, mode' do
          expect(chef_run).to create_template(subject)
            .with(:owner => 'root', :group => 'root', :mode => '0644')
        end # it

        it 'renders file with expected header' do
          expect(chef_run).to render_file(subject)
            .with_content('node.file.header')
        end # it

        it 'notifies resource with expected action' do
          resource = chef_run.template(subject)
          expect(resource).to notify('service[network]').to(:restart).delayed
        end # it
      end # describe

      #-------------------------------------- template[/etc/sysconfig/network]
      describe '/etc/sysconfig/network' do
        it 'creates template with expected owner, group, mode' do
          expect(chef_run).to create_template(subject)
            .with(:owner => 'root', :group => 'root', :mode => '0644')
        end # it

        it 'renders file with expected header' do
          expect(chef_run).to render_file(subject)
            .with_content('node.file.header')
        end # it

        it 'notifies resource with expected action' do
          resource = chef_run.template(subject)
          expect(resource).to notify('service[network]').to(:restart).delayed
        end # it
      end # describe

      #------------------------------------------------------ include_recipe[]
      describe 'simple_iptables' do
        it 'includes described recipe' do
          expect(chef_run).to include_recipe(subject)
        end # it
      end # describe

      #---------------------------------------------- simple_iptables_policy[]
      describe 'INPUT' do
        it 'sets expected chain policy' do
          expect(chef_run).to set_iptables_chain(subject)
            .with_policy('DROP')
        end # it
      end # describe

      describe 'FORWARD' do
        it 'sets expected chain policy' do
          expect(chef_run).to set_iptables_chain(subject)
            .with_policy('DROP')
        end # it
      end # describe

      describe 'OUTPUT' do
        it 'sets expected chain policy' do
          expect(chef_run).to set_iptables_chain(subject)
            .with_policy('ACCEPT')
        end # it
      end # describe

      #------------------------------------------------ simple_iptables_rule[]
      describe 'accept_localhost' do
        it 'appends expected rule' do
          expect(chef_run).to append_iptables_rule(subject)
            .with_chain('RH-Firewall-1-INPUT')
            .with_rule('-i lo')
            .with_jump('ACCEPT')
        end # it
      end # describe

      describe 'drop_unless_begins_with_syn' do
        it 'appends expected rule' do
          expect(chef_run).to append_iptables_rule(subject)
            .with_chain('RH-Firewall-1-INPUT')
            .with_rule('-p tcp ! --syn -m state --state NEW')
            .with_jump('DROP')
        end # it
      end # describe

      describe 'accept_icmp' do
        it 'appends expected rule' do
          expect(chef_run).to append_iptables_rule(subject)
            .with_chain('RH-Firewall-1-INPUT')
            .with_rule(['-p icmp --icmp-type 8', '-p icmp --icmp-type 11'])
            .with_jump('ACCEPT')
        end # it
      end # describe

      describe 'accept_established_related' do
        it 'appends expected rule' do
          expect(chef_run).to append_iptables_rule(subject)
            .with_chain('RH-Firewall-1-INPUT')
            .with_rule('-m state --state ESTABLISHED,RELATED')
            .with_jump('ACCEPT')
        end # it
      end # describe

      [2, 178].each do |port|
        describe "accept_port_#{port}" do
          it 'appends expected rule' do
            expect(chef_run).to append_iptables_rule(subject)
              .with_chain('RH-Firewall-1-INPUT')
              .with_rule("-m state --state NEW -m tcp -p tcp --dport #{port}")
              .with_jump('ACCEPT')
          end # it
        end # describe
      end # [...]

      describe 'reject_other_inbound' do
        it 'appends expected rule' do
          expect(chef_run).to append_iptables_rule(subject)
            .with_chain('RH-Firewall-1-INPUT')
            .with_rule('')
            .with_jump('REJECT --reject-with icmp-host-prohibited')
        end # it
      end # describe

    end # context
  end # [...].each

end # describe
