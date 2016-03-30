class nginx {
    $varwww     = '/var/www'
    $etcnginx   = '/etc/nginx'
    $virt       = capitalize($::virtual)
    notify { "Hello, my name is ${virt}": }
    File {
    	owner   => 'root',
    	group   => 'root',
    	mode    => '0664',
    	require => Package['nginx'],
    	notify  => Service['nginx'],    	
    }
    package { 'nginx':
    	ensure  => present,
    }
    file { [$varwww, '/etc/nginx/conf.d']:
    	ensure  => directory,
    }	
    file { "${varwww}/index.html":
    	ensure  => file,
    	source  => 'puppet:///modules/nginx/index.html',
    }
    file { "${etcnginx}/nginx.conf":
    	ensure  => file,
    	source  => 'puppet:///modules/nginx/nginx.conf',
    }
    file { "${etcnginx}/conf.d/default.conf":
    	ensure  => file,
    	source  => 'puppet:///modules/nginx/default.conf',
    }
    service { 'nginx':
    	ensure => running,
    	enable => true,
    }
}
