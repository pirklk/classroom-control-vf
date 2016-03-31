class nginx {
    ##$osfamily = $::osfamily
    ##$virt         = capitalize($::virtual)
    ##notify { "Hello, my name is ${virt}\n": }
        notify { "Hello0\n": } 
    case $::osfamily {
        'redhat','debian' : {
            $package_name = 'nginx'
            $service_name = 'nginx'
            $file_owner   = 'root'
            $file_group   = 'root'
            $doc_root     = '/var/www'
            $config_dir   = '/etc/nginx'
            $svr_blk_dir  = '/etc/nginx/conf.d'
            $log_dir      = '/var/log/nginx'
            $usr_run_as   = 'nginx'
    notify { "Hello1\n": } 
        }
    }        
        'windows' : {
            $package_name = 'nginx-service'
            $service_name = 'nginx'
            $file_owner   = 'Administrator'
            $file_group   = 'Administrators'
            $doc_root     = 'C:/ProgramData/nginx/html'
            $config_dir   = 'C:/ProgramData/nginx'
            $svr_blk_dir  = 'C:/ProgramData/nginx/conf.d'
            $log_dir      = 'C:/ProgramData/nginx/logs'
            $usr_run_as   = 'nobody'
  notify { "Hello3\n": } 
        }        
        default : {
            fail("Module ${module_name} Y is not supported on ${::osfamily}")
        }
    }
    $user = $::osfamily ? {
        'redhat' => 'nginx',
        'debian' => 'www-data',
        'windows' => 'nobody',
    }
    File {
    	owner   => $owner,
    	group   => $group,
    	mode    => '0664',
    }
    package { $package_name:
    	ensure  => present,
    }
    file { [$doc_root, $svr_blk_dir]:
    	ensure  => directory,
    }	
    file { "${doc_root}/index.html":
    	ensure  => file,
    	source  => 'puppet:///modules/nginx/index.html',
    }
    file { "${config_dir}/nginx.conf":
    	ensure  => file,
    	content => template('nginx/nginx.conf.erb'),
    	notify => Service['nginx'],
    }
    file { "${svr_blk_dir}/default.conf":
    	ensure  => file,
    	content => template('nginx/default.conf.erb'),
    	notify => Service['nginx'],    	
    }
    service { $service_name:
    	ensure => running,
    	enable => true,
    }
}
