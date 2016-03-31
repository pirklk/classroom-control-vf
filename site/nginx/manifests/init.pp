class nginx (
  $package = $nginx::params::package,
  $owner = $nginx::params::owner,
  $group = $nginx::params::group,
  $docroot = $nginx::params::docroot,
  $confdir = $nginx::params::confdir,
  $logdir = $nginx::params::logdir,
  $user = $nginx::params::user,
) inherits nginx::params {
  File {
    owner => $owner,
    group => $group,
    mode => '0664',
  }
  package { $package:
    ensure => present,
  }
  file { [ $docroot, "${confdir}/conf.d" ]:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${confdir}/nginx.conf":
    ensure => file,
    content => template('nginx/nginx.conf.erb'),
    notify => Service['nginx'],
  }
  file { "${confdir}/conf.d/default.conf":
    ensure => file,
    content => template('nginx/default.conf.erb'),
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}


/*

class nginx (
  $root = undef,
) {
  case $::osfamily {
    'redhat','debian' : {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $documentroot = '/var/www'
      $default_docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir = '/var/log/nginx'
    }
    'windows' : {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $documentroot = 'C:/ProgramData/nginx/html'
      $default_docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $logdir = 'C:/ProgramData/nginx/logs'
    }
    default : {
      fail("OS Family is not supported on ${::osfamily}")
    }
  }
  $docroot = $root ? {
    undef => $default_docroot,
    default => $root
  }
  
  # user the service will run as. Used in the nginx.conf.erb template
  $user = $::osfamily ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody',
  }
  
  File {
    owner => $owner,
    group => $group,
    mode => '0664',
  }
  package { $package:
    ensure => present,
  }
  
  file { [ $docroot, "${confdir}/conf.d" ]:
    ensure => directory,
  }
  
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { "${confdir}/nginx.conf":
    ensure => file,
    content => template('nginx/nginx.conf.erb'),
    notify => Service['nginx'],
  }
  
  file { "${confdir}/conf.d/default.conf":
    ensure => file,
    content => template('nginx/default.conf.erb'),
    notify => Service['nginx'],
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
  }
  
}

*/

