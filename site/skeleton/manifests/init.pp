class skeleton {

  file { '/etc/skel':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0644'
  }
  
}
