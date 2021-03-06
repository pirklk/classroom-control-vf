## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Disable filebucket by default for all File resources:
File { backup => false }

# Randomize enforcement order to help understand relationships
ini_setting { 'random ordering':
  ensure  => present,
  path    => "${settings::confdir}/puppet.conf",
  section => 'agent',
  setting => 'ordering',
  value   => 'title-hash',
}

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {

  include profile::wordpress
  


  ## Lab 18.2 nginx
  #include nginx

  ## Lab 18.1 nginx
  #include nginx
  #class { 'nginx' :
  #  root => '/var/www/html',
  #}

  ## Lab 17.1
  #$message = hiera('message')
  #notify { "The Hiera message is: ${message}": }
  
  ## Lab 11.2 nginx
  #include nginx
  
  ## Lab 13.2 nginx
  #if $::virtual != 'physical' {
  #  $vmname = capitalize($::virtual)
  #  notify { "This is a ${nginx::virt} virtual machine.\n": }
  #}  

  ## Lab 11.1 memcached
  #include memcached

  ## Lab 9.2 - 9.3 - Declare & Test the skeleton class include
  #include skeleton

  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  # notify { "Hello, my name is ${::hostname}": }
  #file { '/etc/motd':
  #  ensure => file,
  #  owner => 'root',
  #  group => 'root',
  #  mode => '0644',
  #  content => "Hey, Hello World, Puppet is fun!\n",
  #}
  #exec { "cowsay 'Welcome to ${::fqdn}!' > /etc/motd" :
  #  path => '/usr/local/bin'
  #}
  host { 'testing.puppetlabs.vm':
    ensure       => present,
    ip           => '127.0.0.1',
  }
  include users
  include users::admins
}
