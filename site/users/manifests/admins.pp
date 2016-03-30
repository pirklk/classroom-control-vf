class users::admins {

  user { 'jose':
      shell => '/bin/sh',
      home => '/home/jose',
  ##    uid => '444',
  ##    gid => '444',
      ensure => 'absent',
      password => '!'
  }

  users::managed_user {'jose':}
  
  users::managed_user {'alice':
    group => 'staff',
  }
  
  users::managed_user {'chen':
    group => 'staff',
  }
  
  group {'staff':
    ensure => present,
  }
  
}
