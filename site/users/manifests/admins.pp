class users::admins {

  user { 'bob':
      shell => '/bin/sh',
      home => '/home/bob',
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
