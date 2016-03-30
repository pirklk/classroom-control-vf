class nginx {
	$varwww = '/var/www'
	$etcnginx = '/etc/nginx'
	File {
		owner => 'root',
		group => 'root',
		mode => '0664',
	}
	package { 'nginx':
		ensure => present,
	}
	file { [$varwww, '/etc/nginx/conf.d']:
		ensure => directory,
	}	
	file { "${varwww}/index.html":
		ensure => file,
		source => 'puppet:///modules/nginx/index.html',
	}
	file { "${etcnginx}/nginx.conf":
		ensure => file,
		source => 'puppet:///modules/nginx/nginx.conf',
		require => Package['nginx'],
		notify => Service['nginx'],
	}
	file { "${etcnginx}/conf.d/default.conf":
		ensure => file,
		source => 'puppet:///modules/nginx/default.conf',
		require => Package['nginx'],
		notify => Service['nginx'],
	}
	service { 'nginx':
		ensure => running,
		enable => true,
	}
}
