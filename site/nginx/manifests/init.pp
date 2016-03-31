class nginx (
  $package = $nginx::params::package,
  $owner   = $nginx::params::owner,
  $group   = $nginx::params::group,
  $confdir = $nginx::params::confdir,
  $logdir  = $nginx::params::logdir,
  $docroot = $nginx::params::docroot,
  $root    = $nginx::params::root,
) inherits nginx::params {
  File {
    owner => $owner,
    group => $group,
    mode  => '0644',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  package { 'nginx':
    ensure => installed,
    name   => $package,
  }
  
  file { "${confdir}/nginx.conf":
    ensure => file,
    #source => 'puppet:///modules/nginx/nginx.conf',
    content => template('nginx/nginx.conf.erb'),
  }
  
  file { "${confdir}/conf.d/default.conf":
    ensure => file,
    #source => 'puppet:///modules/nginx/default.conf',
    content => template('nginx/default.conf.erb'),
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
  }
  
  file { $docroot:
    ensure => directory,
  }
  
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
}
