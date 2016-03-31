class nginx::params {
  case $::osfamily {
    'redhat', 'debian': {
      $package = 'nginx'
      $owner   = 'root'
      $group   = 'root'
      $confdir = '/etc/nginx'
      $logdir  = '/var/log/nginx'
      $docroot = '/var/www'
    }
    'windows': {
      $package = 'nginx-service'
      $owner   = 'Administrator'
      $group   = 'Administrators'
      $confdir = 'C:/ProgramData/nginx'
      $logdir  = 'C:/ProgramData/nginx/logs'
      $docroot = 'C:/ProgramData/nginx/html'
    }
    default: { fail("OS Family ${::osfamily} is not supported with this nginx module") }
  }

  ## Because Redhat and Debian are different here, we can't specify the user of
  ## of the nginx service in the big case statement above. Thus we have the
  ## selector here...
  $user = $::osfamily ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody',
  }
 }
