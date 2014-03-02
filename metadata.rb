# encoding: utf-8
name              'network'
maintainer        'James Hardie Building Products, Inc.'
maintainer_email  'doc.walker@jameshardie.com'
description       'Configures network'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
license           'Apache 2.0'
version           '0.4.0'

#--------------------------------------------------------------------- recipes
recipe            'network',
                  'Includes network::hosts and network::network'
recipe            'network::common',
                  'Provides the network service which can be restarted ' \
                  'from the other recipes'
recipe            'network::dns_tools',
                  'Installs the appropriate package containing dns utilities'
recipe            'network::firewall',
                  'Configures the iptables firewall'
recipe            'network::hosts',
                  'Installs the /etc/hosts configuration file'
recipe            'network::network',
                  'Installs the /etc/sysconfig/network configuration file'

#------------------------------------------------------- cookbook dependencies
depends           'simple_iptables'

#--------------------------------------------------------- supported platforms
# tested
supports          'centos'

# platform_family?('rhel'): not tested, but should work
supports          'amazon'
supports          'oracle'
supports          'redhat'
supports          'scientific'

# platform_family?('debian'): not tested, but may work
supports          'debian'
supports          'ubuntu'
