matrix_server Cookbook
======================
[![Travis](https://img.shields.io/travis/jhx/cookbook-matrix_server.svg?style=flat)][travis]
[![Gemnasium](http://img.shields.io/gemnasium/jhx/cookbook-matrix_server.svg?style=flat)][gemnasium]

[travis]:       https://travis-ci.org/jhx/cookbook-matrix_server
[gemnasium]:    https://gemnasium.com/jhx/cookbook-matrix_server

Installs and configures Matrix Server on client nodes.


Requirements
------------
### Cookbooks
The following cookbooks are direct dependencies because they're used for common "default" functionality.

- [`build-essential`](https://supermarket.chef.io/cookbooks/build-essential)
- [`chef-sugar`](https://supermarket.chef.io/cookbooks/chef-sugar)
- [`cron`](https://supermarket.chef.io/cookbooks/cron)
- [`database`](https://supermarket.chef.io/cookbooks/database)
- [`java`](https://supermarket.chef.io/cookbooks/java)
- [`logrotate`](https://supermarket.chef.io/cookbooks/logrotate)
- [`mysql`](https://supermarket.chef.io/cookbooks/mysql)
- [`nodejs`](https://supermarket.chef.io/cookbooks/nodejs)
- [`ohai`](https://supermarket.chef.io/cookbooks/ohai)
- [`openssh`](https://supermarket.chef.io/cookbooks/openssh)
- [`rvm`](https://supermarket.chef.io/cookbooks/rvm)
- [`selinux`](https://supermarket.chef.io/cookbooks/selinux)
- [`ssh_known_hosts`](https://supermarket.chef.io/cookbooks/ssh_known_hosts)
- [`sudo`](https://supermarket.chef.io/cookbooks/sudo)
- [`sysctl`](https://supermarket.chef.io/cookbooks/sysctl)
- [`user`](https://supermarket.chef.io/cookbooks/user)
- [`yum-epel`](https://supermarket.chef.io/cookbooks/yum-epel)


### Platforms
The following platforms are supported and tested under Test Kitchen:

- CentosOS 5.10, 6.5

Other RHEL family distributions are assumed to work. See [TESTING](TESTING.md) for information about running tests in Opscode's Test Kitchen.


Attributes
----------
Refer to `attributes/default.rb` for default values.


Recipes
-------
This cookbook provides one main recipe for configuring a node.

- `default.rb` - *Use this recipe* to install and configure `matrix_server`.

### default
This recipe installs and configures `matrix_server`.


Usage
-----
On client nodes, use the default recipe:

````javascript
{ "run_list": ["recipe[matrix_server]"] }
````

The following are the key items achieved by this cookbook:

- add something
- add something else
- add another item


License & Authors
-----------------
- Author:: Doc Walker (<doc.walker@jameshardie.com>)

````text
Copyright:: 2013-2015, James Hardie Building Products, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
````
