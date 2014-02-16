network Cookbook
================
[![Build Status](https://travis-ci.org/jhx/cookbook-network.png?branch=master)](https://travis-ci.org/jhx/cookbook-network)
[![Dependency Status](https://gemnasium.com/jhx/cookbook-network.png)](https://gemnasium.com/jhx/cookbook-network)

Configures network.


Requirements
------------
### Cookbooks
The following cookbook is a direct dependency because it's used for common "default" functionality.

- `simple_iptables` (for `network::firewall`)

### Platforms
The following platforms are supported and tested under Test Kitchen:

- CentosOS 5.10, 6.5

Other RHEL family distributions are assumed to work. See [TESTING](TESTING.md) for information about running tests in Opscode's Test Kitchen.


Attributes
----------
Refer to [`attributes/default.rb`](attributes/default.rb) for default values.

- `node['network']['hosts']['127.0.0.1']` - hostnames for 127.0.0.1
- `node['network']['hosts'][node['ipaddress']]` - hostnames for external IP address
- `node['network']['firewall']` - array of ports to open in the firewall


Recipes
-------
This cookbook provides one main recipe for configuring the network.

- `default.rb` - *Use this recipe* to configure the network.

### common
This recipe provides the `network` service which can be restarted from the other recipes.

### default
This recipe includes `network::hosts` and `network::network`.

### dns_tools
This recipe installs the appropriate package containing dns utilities.

### firewall
This recipe configures the `iptables` firewall.

### hosts
This recipe installs the `/etc/hosts` configuration file.

### network
This recipe installs the `/etc/sysconfig/network` configuration file.


Usage
-----
On client nodes, use the default recipe:

````javascript
{ "run_list": ["recipe[network]"] }
````

The following are the key items achieved by this cookbook:

- installs `/etc/hosts` configuration file
- installs `/etc/sysconfig/network` configuration file


License & Authors
-----------------
- Author:: Doc Walker (<doc.walker@jameshardie.com>)

````text
Copyright 2013-2014, James Hardie Building Products, Inc.

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
