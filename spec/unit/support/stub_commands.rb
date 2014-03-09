# encoding: utf-8

# place chefspec stub_commands here (alphabetical order)
RSpec.configure do |config|
  config.before do
    #---------------------------------------- recipe[matrix_server::passenger]
    stub_command("bash -c \"source /etc/profile && type rvm | " \
      "cat | head -1 | grep -q '^rvm is a function$'\"").and_return(true)

    #--------------------------------------------- recipe[matrix_server::sudo]
    stub_command('sudo -V').and_return(true)

    #--------------------------------------------------- recipe[mysql::server]
    stub_command("\"/usr/bin/mysql\" -u root -e 'show databases;'")
      .and_return(true)

    #--------------------------------------------- recipe[selinux::permissive]
    stub_command("getenforce | egrep -qx 'Permissive|Disabled'")
      .and_return(true)
    stub_command("getenforce | grep -qx 'Disabled'").and_return(true)
  end # config.before
end # RSpec
